Dir[File.join('.', '**/*.rb')].each { |f| require f }
# Entrypoint in application
class Application
  DEFAULT_EPS = 0.2

  def main(args)
    telegram_bot = Control::TelegramBot.new
    cc = Control::Camera.new(args[:cam].to_i || 0)
    tmp = cc.image
    puts "System standby from #{Time.now}"
    loop do
      next unless telegram_bot.start_message_received?

      current_image = cc.image
      unless Algorithm.compare_images(current_image, tmp,
                                      (args[:eps].to_f || DEFAULT_EPS))
        message = "Security breach detected - #{Time.now}"
        filepath = "images/security_breach/image_#{Time.now.to_i}.png"
        current_image.save(filepath)
        telegram_bot.send_message(message, filepath)
        puts message
        telegram_bot.stop_connection
      end
      tmp = current_image
    end
    cc.destruct
  end
end

begin
  Application.new.main(Commander.new.command)
rescue StandardError
  puts 'Invalid input data'
  exit!
end
