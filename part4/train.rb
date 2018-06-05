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
    @current_speed = new_speed if new_speed >= 0
  end

  def add_wagon
    @wagon_count += 1
  end

  def detach_wagon
    @wagon_count -= 1 if @wagon_count > 0
  end

  def accept_route(route)
    @route = route.stations
    start_station = @route[0]
    start_station.take_train(self)
    @current_index = 0
  end

  def forward
    if @current_index == @route.size-1
      puts "Поезд достиг конца маршрута."
    else
      current_station = @route[@current_index]
      current_station.send_train(self)
      @current_index += 1
      current_station = @route[@current_index]
      current_station.take_train(self)
    end
  end

  def backward
    if @current_index == 0
      puts "Поезд достиг начала маршрута."
    else
      current_station = @route[@current_index]
      current_station.send_train(self)
      @current_index -= 1
      current_station = @route[@current_index]
      current_station.take_train(self)
    end
  end

  def next_station
    @route[@current_index+1]
  end

  def prev_station
    @route[@current_index-1]
  end
end
