require_relative "manufacturer.rb"
require_relative 'exception_handler.rb'

class Wagon
  attr_reader :type, :number, :taken_volume, :total_volume
  attr_accessor :train, :manufacturer
  attr_reader
  include Manufacturer
  include ExceptionHandler
  @@wagons = {}

  def initialize(number, type, volume)
    @number = number
    @type = type
    @total_volume = volume >= 0 ? volume : 0
    @taken_volume = 0
    init_validate
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

  protected

  def validate!
    raise "Номер не может быть пустым" if number.nil?
    raise "Неправильный формат номера" if number !~ NUMBER_FORMAT
    raise "Неизвестный тип вагона" unless %i[cargo pass].include?(type)
    raise "Такой вагон уже добавлен" if @@wagons.key?(number)
  end
end
