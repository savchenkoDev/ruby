require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'
require_relative 'exception_handler.rb'
# class
class Train
  include Manufacturer
  include InstanceCounter
  include ExceptionHandler
  attr_reader :current_speed, :number, :route, :type, :wagons
  @@trains = {}
  class <<self
    def find(number)
      @@trains[number]
    end
  end

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @current_speed = 0
    init_validate
    @@trains[number] = self
    register_instance
  end

  def each_wagon
    @wagons.each { |wagon| yield(wagon) }
  end

  def next_station
    @route.stations[@current_index + 1]
  end

  def current_station
    @route.stations[@current_index]
  end

  def prev_station
    return if @current_index - 1 < 0
    @route.stations[@current_index - 1]
  end

  def accept_route(route)
    @route = route
    start_station = @route.stations.first
    start_station.take_train(self)
    @current_index = 0
  end

  def add_wagon(wagon)
    return unless @type == wagon.type
    return unless @current_speed.zero?
    @wagons << wagon
    wagon.add_to_train(self)
  end

  def unhook_wagon(wagon)
    @wagons.delete(wagon)
    wagon.train = nil
  end

  def move_forward
    return unless next_station
    current_station.send_train(self)
    next_station.take_train(self)
    @current_index += 1
  end

  def move_backward
    return unless prev_station
    current_station.send_train(self)
    prev_station.take_train(self)
    @current_index -= 1
  end

  protected

  def validate!
    raise 'Номер не может быть пустым' if number.nil?
    raise 'Неправильный формат номера' if number !~ NUMBER_FORMAT
    raise 'Неизвестный тип поезда' unless %i[cargo pass].include?(type)
  end

  def speed_ud(speed)
    @current_speed += speed
  end

  def speed_down(speed)
    @current_speed -= speed
    @current_speed = 0 if @current_speed.negative?
  end
end
