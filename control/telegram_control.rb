require 'telegram/bot'
require 'yaml'

module Control
  class TelegramBot
    START_COMMAND = '/start'.freeze
    EXIT_COMMAND = '/exit'.freeze

    def initialize
      @is_started = false
      Telegram::Bot::Client.run(YAML.load_file('secrets.yml')['TELEGRAM_BOT_TOKEN']) do |bot|
        @bot = bot
      end
    end

    def send_message(text, img_path)
      @bot.api.send_message(chat_id: YAML.load_file('secrets.yml')['USER_GUID'], text: text)
      @bot.api.send_photo(chat_id: YAML.load_file('secrets.yml')['USER_GUID'], photo: Faraday::UploadIO.new(img_path, 'image/png')) unless img_path.empty?
    end

    def start_message_received?
      return true if @is_started

      @bot.listen do |message|
        if message.text == START_COMMAND && message.chat.id == YAML.load_file('secrets.yml')['USER_GUID']
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
