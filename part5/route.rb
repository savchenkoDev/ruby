class Route
  attr_reader :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
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

  private

  def extreme_position?(position)
    @stations[position] == @stations[0] || @stations[position] == @stations[-1]
  end
end
