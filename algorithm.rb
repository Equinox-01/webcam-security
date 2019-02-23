class Algorithm
  def self.compare_images(original, taken, eps) # Returns true if images identical
    counter = 0
    image = original.abs_diff(taken)
    (0...image.height).each do |height_count|
      (0...image.width).each do |width_count|
        pixel = image[height_count, width_count]
        counter += 1 if pixel[0] <= 10 && pixel[1] <= 10 && pixel[2] <= 10
      end
    end
    counter / (image.width * image.height).to_f > 1 - eps
  end
end
