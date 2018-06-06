class Route
  attr_reader :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
  end

  def extreme_position?(station)
    station == stations[0] || station == stations[-1]
  end

  def add_station(station, position = -2)
    return if @stations.include?(station) || extreme_position?(station)
    @stations.insert(position, station)
  end

  def delete_station(station)
    return if extreme_position?(station) || !@stations.include?(station)
    @stations.delete(station)
  end

  def show
    @stations.each { |station| puts station.name }
  end
end
