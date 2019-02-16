require 'opencv'

module Control
  class Camera
    include OpenCV

    def initialize
      @capture = OpenCV::CvCapture.open
      sleep 1 # Warming up the webcam
    end

    def image
      raise NotImplementedError # TODO: Do we need that method here ?
    end

    def save_on_disk(path)
      @capture.query.save("#{path}/image_#{Time.now.to_i}.png")
    end

    def destruct
      @capture.close
    end
  end
end
