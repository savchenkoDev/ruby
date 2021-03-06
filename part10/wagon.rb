require_relative 'manufacturer.rb'
require_relative 'validation.rb'
require_relative 'accessors.rb'

class Wagon
  include Manufacturer
  include Validation
  extend Accessors

  attr_reader :type, :number, :taken_volume, :total_volume
  attr_accessor_with_history :train, :manufacturer
  attr_reader

  @@wagons = {}

  def initialize(number, type, volume)
    @number = number
    @type = type
    @total_volume = volume >= 0 ? volume : 0
    @taken_volume = 0
    validate!
    @@wagons[number] = self
  end

  def add_to_train(train)
    @train = train
  end

  def take_volume(volume)
    @taken_volume += overload(volume)
  end

  def free_volume
    @total_volume - @taken_volume
  end

  def overload(amount)
    return 0 if amount < 0
    amount > free_volume ? free_volume : amount
  end
end
