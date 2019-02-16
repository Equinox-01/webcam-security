require 'opencv'

module Control
  class Camera
    include OpenCV

    def initialize
      @capture = OpenCV::CvCapture.open
      sleep 1 # Warming up the webcam
    end

    def image
      @capture.query
    end

    def destruct
      @capture.close
    end
  end
end
