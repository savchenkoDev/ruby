require_relative "manufacturer.rb"

class Wagon
  attr_reader :type, :number
  attr_accessor :train, :manufacturer
  include Manufacturer

  def initialize(number,type)
    @number = number
    @type = type
  end

  def add_to_train(train)
    @train = train
  end
end
