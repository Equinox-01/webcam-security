Dir[File.join('.', '**/*.rb')].each { |f| require f }

def main
  telegram_bot = Control::TelegramBot.new
  cc = Control::Camera.new
  tmp = cc.image
  puts 'System stand by ...'
  loop do
    next unless telegram_bot.start_message_received?

    current_image = cc.image
    if Algorithm.compare_images(current_image, tmp)
      message = "Security breach detected - #{Time.now}"
      filepath = "images/security_breach/image_#{Time.now.to_i}.png"
      current_image.save(filepath)
      telegram_bot.send_message(message, filepath)
      puts message
      telegram_bot.stop_connection
    end
    sleep 3
  end
  cc.destruct
end

main
