require_relative "manufacturer.rb"
require_relative 'exception_handler.rb'

class Wagon
  attr_reader :type, :number
  attr_accessor :train, :manufacturer
  include Manufacturer
  include ExceptionHandler
  @@wagons = {}

  def initialize(number,type)
    @number = number
    @type = type
    init_validate
    puts "Создан вагон: № #{number}, тип: #{type}"
    @@wagons[number] = self
  end

  def add_to_train(train)
    @train = train
  end

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise "Номер не может быть пустым" if number.nil?
    raise "Неправильный формат номера" if number !~ NUMBER_FORMAT
    raise "Такой вагон уже добавлен" if @@wagons.key?(number)
    true
  end
end
