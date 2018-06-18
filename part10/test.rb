require_relative 'validation.rb'
# class
class Test
  include Validation
  attr_accessor :arg

 validate :arg, :type, String


  def initialize(arg)
    @arg = arg
    validate!
  end
end
