class Route
  attr_reader :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
  end

  def extreme_position?(position)
    [0, stations.size - 1, -1, -stations.size].include?(position)
  end

# Ранний возврат, если станция уже есть в маршруте,
# или если пытаются изменить начальную/конечную
# если добавляем в первый раз, то пишет на первую позицию
  def add_station(station, position = -2)
    return false if @stations.include?(station) || extreme_position?(position)

    position = 1 if stations.size == 2
    @stations.insert(position, station)

  end

  def delete_station(station)
    return false if !@stations.include?(station)
    return false if station = @stations.last && station = @stations.first

    @stations.delete(station)
  end

  def show
    @stations.each { |station| puts station.name }
  end
end
