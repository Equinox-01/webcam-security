# Using for image processing
class Algorithm
  COLOR_DEFINITION = 10

  # Returns true if images identical
  def self.compare_images(original, taken, eps)
    counter = 0
    image = original.abs_diff(taken)
    (0...image.height).each do |height_count|
      (0...image.width).each do |width_count|
        pixel = image[height_count, width_count]
        counter += 1 if pixel[0] <= COLOR_DEFINITION &&
                        pixel[1] <= COLOR_DEFINITION &&
                        pixel[2] <= COLOR_DEFINITION
      end
    end
    counter / (image.width * image.height).to_f > 1 - eps
  end
end
