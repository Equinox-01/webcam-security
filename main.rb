require 'pry'
require 'require_all'
require_all './'

def main
  cc = Control::Camera.new
  # binding.pry
  cc.destruct
end

main
