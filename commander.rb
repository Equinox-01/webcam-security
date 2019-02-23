require 'optparse'
# Class using for processing terminal arguments
class Commander
  def command
    @options = {}

    OptionParser.new do |parser|
      help_param parser
      cam_param parser
      eps_param parser
    end.parse!
    @options
  end

  private

  def help_param(parser)
    parser.on('-h', '--help', 'Show this help :-)') do
      puts parser
      exit!
    end
  end

  def cam_param(parser)
    parser.on('-c', '--cam CAM', 'Number of webcam.') do |variable|
      @options[:cam] = variable
      raise 'Cam number invalid.' unless Integer(@options[:cam]) >= 0
    end
  end

  def eps_param(parser)
    parser.on('-e', '--eps EPS', 'EPS for algorithm.') do |variable|
      @options[:eps] = variable
      raise 'EPS invalid.' unless Float(@options[:eps]) &&
                                  (@options[:eps].to_f > 0 &&
                                   @options[:eps].to_f < 1)
    end
  end
end
