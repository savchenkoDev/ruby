require_relative "manufacturer.rb"
require_relative 'exception_handler.rb'

class Wagon
  attr_reader :type, :number, :taken_position, :total_position
  attr_accessor :train, :manufacturer
  attr_reader
  include Manufacturer
  include ExceptionHandler
  @@wagons = {}

  def initialize(number, type, amount)
    @number = number
    @type = type
    @total_position = amount >= 0 ? amount : 0
    @taken_position = 0
    init_validate
    @@wagons[number] = self
  end

  def add_to_train(train)
    @train = train
  end

  def take_position(amount)
    volume = overload(amount)
    @taken_position += volume
  end

  def free_position
    @total_position - @taken_position
  end

  def overload(amount)
    return 0 if amount < 0
    @taken_position + amount > @total_position ? free_position : amount
  end

  protected

  def validate!
    raise "Номер не может быть пустым" if number.nil?
    raise "Неправильный формат номера" if number !~ NUMBER_FORMAT
    raise "Неизвестный тип вагона" unless %i[cargo pass].include?(type)
    raise "Такой вагон уже добавлен" if @@wagons.key?(number)
  end
end
