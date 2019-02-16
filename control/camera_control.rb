require 'opencv'

module Control
  class Camera
    include OpenCV

    def initialize(cam_number)
      @capture = OpenCV::CvCapture.open cam_number
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
