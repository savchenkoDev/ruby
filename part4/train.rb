class Train
  attr_reader :current_speed, :number, :route, :type, :wagon_count

  def initialize(number, type, wagon_count)
    @number = number
    @type = type
    @wagon_count = wagon_count
    @current_speed = 0
  end

	def speed_ud(speed)
    @current_speed += speed
  end

  def speed_down(speed)
    new_speed = @current_speed - speed
    @current_speed = new_speed >= 0 ? new_speed : 0
  end

  def stop?
    @current_speed == 0 if @current_speed == 0
  end

  def detach_wagon

    @wagon_count -= 1 if @wagon_count > 0 && @current_speed == 0
  end

  def accept_route(route)
    @route = route#.stations
    start_station = @route.stations.first
    start_station.take_train(self)
    @current_index = 0
  end

  def forward
    if @current_index == @route.stations.size - 1
      puts "Поезд достиг конца маршрута."
    else
      @current_index += 1
      current_station = @route.stations[@current_index]
      prev_station.send_train(self)
      current_station.take_train(self)
    end
  end

  def backward
    if @current_index == 0
      puts "Поезд достиг начала маршрута."
    else
      @current_index -= 1
      current_station = @route.stations[@current_index]
      next_station.send_train(self)
      current_station.take_train(self)
    end
  end

  def next_station
    @route.stations[@current_index+1]
  end

  def prev_station
    @route.stations[@current_index-1]
  end
end
