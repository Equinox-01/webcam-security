require 'telegram/bot'
require 'yaml'

module Control
  # Using for work with TelegramBot
  class TelegramBot
    START_COMMAND = '/start'.freeze
    EXIT_COMMAND = '/exit'.freeze
    IMAGE_TYPE = 'image/png'.freeze

    SECRETS = YAML.load_file('secrets.yml').freeze

    def initialize
      @is_started = false
      Telegram::Bot::Client.run(SECRETS['TELEGRAM_BOT_TOKEN']) do |bot|
        @bot = bot
      end
    end

    def send_message(text, img_path)
      @bot.api.send_message(chat_id: SECRETS['USER_GUID'], text: text)
      return if img_path.empty?

      @bot.api.send_photo(chat_id: SECRETS['USER_GUID'],
                          photo: Faraday::UploadIO.new(img_path, IMAGE_TYPE))
    end

    def start_message_received?
      return true if @is_started

      @bot.listen do |message|
        if message.text == START_COMMAND &&
           message.chat.id == SECRETS['USER_GUID']
          @is_started = true
          return @is_started
        end
      end
    end

    def stop_connection
      @is_started = false
    end
  end
end
