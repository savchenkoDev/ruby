class Route
  attr_reader :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
  end

  def add_station(station, position)
    if @stations.include?(station)
      puts "Станция уже есть в маршруте"
    elsif stations.size == 2
      @stations.insert(1, station)
    elsif position != 0 && position != stations.size - 1
      @stations.insert(position, station)
    else
      puts "Нельзя изменить начальную/конечную станцию"
    end
  end

  def delete_station(station)
    if !@stations.include?(station)
      puts "Такой станции нет в маршруте"
    elsif station != @stations.last && station != @stations.first
      self.stations.delete(station)
    else
      puts "Нельзя удалить начальную/конечную станцию"
    end
  end

  def show
    @stations.each { |station| puts station.name }
  end
end
