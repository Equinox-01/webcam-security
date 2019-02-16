require 'pry'
require 'require_all'
require_all './'

def main
  cc = Control::Camera.new
  tmp = cc.image
  while 1
    current_image = cc.image
    if Algorithm.compare_images(current_image, tmp)
      puts 'kek' # TODO: Change to telegram-bot message with image
      current_image.save("images/security_breach/image_#{Time.now.to_i}.png")
    end
    sleep 3
  end
  cc.destruct
end

main
