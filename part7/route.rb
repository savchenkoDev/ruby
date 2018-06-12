require_relative "instance_counter.rb"
require_relative 'exception_handler.rb'

class Route
  include InstanceCounter
  include ExceptionHandler

  attr_reader :stations, :title

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
    @title = "#{start_station.name} - #{finish_station.name}"
    init_validate
    puts "Создан маршрут: #{title}"
    register_instance
  end

  def add_station(station, position = -2)
    return if @stations.include?(station)
    return @stations.insert(1, station) if @stations.size == 2
    @stations.insert(position, station) unless extreme_position?(position)
  end

  def delete_station(station)
    index = @stations.index(station)
    return unless @stations.include?(station)
    @stations.delete(station) unless extreme_position?(index)
  end

  def show
    @stations.each { |station| puts station.name }
  end

  def valid?
    validate!
  rescue
    false
  end

  private

  def validate!
    raise "Начальная и конечная станция не могут совпадать" if @stations[0] == @stations[-1]
  end

  def extreme_position?(position)
    @stations[position] == @stations[0] || @stations[position] == @stations[-1]
  end
end
