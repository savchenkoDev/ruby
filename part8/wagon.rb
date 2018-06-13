require_relative "manufacturer.rb"
require_relative 'exception_handler.rb'

class Wagon
  attr_reader :type, :number
  attr_accessor :train, :manufacturer
  include Manufacturer
  include ExceptionHandler
  @@wagons = {}

  def initialize(number,type, count)
    begin
      raise "Количество не может быть отрицательным" if count < 0
    rescue Exception => e
      puts "Ошибка: #{e.message}"
      raise e
    end
    @number = number
    @type = type
    init_validate
    @@wagons[number] = self
  end

  def add_to_train(train)
    @train = train
  end

  protected

  def validate!
    raise "Номер не может быть пустым" if number.nil?
    raise "Неправильный формат номера" if number !~ NUMBER_FORMAT
    raise "Неизвестный тип вагона" unless %i[cargo pass].include?(type)
    raise "Такой вагон уже добавлен" if @@wagons.key?(number)
  end
end
