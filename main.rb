Dir[File.join('.', '**/*.rb')].each { |f| require f }

def main
  cam_number = 0
  cam_number = ARGV[0].to_i unless ARGV.empty?
  telegram_bot = Control::TelegramBot.new
  cc = Control::Camera.new cam_number
  tmp = cc.image
  puts "System standby from #{Time.now}"
  loop do
    next unless telegram_bot.start_message_received?

    current_image = cc.image
    unless Algorithm.compare_images(current_image, tmp)
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

main
