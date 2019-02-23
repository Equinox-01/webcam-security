require 'optparse'

def command
  options = {}

  OptionParser.new do |parser|
    parser.on('-h', '--help', 'Show this help :-)') do |v|
      puts parser
      exit!
    end

    parser.on('-c', '--cam CAM', 'Number of webcam.') do |v|
      options[:cam] = v
      raise 'Cam number invalid.' unless Integer(options[:cam]) >= 0
    end

    parser.on('-e', '--eps EPS', 'EPS for algorithm.') do |v|
      options[:eps] = v
      raise 'EPS invalid.' unless Float(options[:eps]) &&
                                  (options[:eps].to_f > 0 && options[:eps].to_f < 1)
    end
  end.parse!
  options
end
