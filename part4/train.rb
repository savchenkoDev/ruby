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
    @current_speed -= speed
    @current_speed = 0 if @current_speed.negative?
  end

  def add_wagon
    @wagon_count += 1 if @current_speed == 0
  end

  def detach_wagon
    @wagon_count -= 1 if @wagon_count > 0 && @current_speed == 0
  end

  def accept_route(route)
    @route = route
    start_station = @route.stations.first
    start_station.take_train(self)
    @current_index = 0
  end

  def forward
    return if !next_station
    current_station.send_train(self)
    next_station.take_train(self)
    @current_index += 1
  end

  def backward
    return if !prev_station
    current_station.send_train(self)
    prev_station.take_train(self)
    @current_index -= 1
  end

  def next_station
    @route.stations[@current_index + 1]
  end

  def current_station
    @route.stations[@current_index]
  end

  def prev_station
    @route.stations[@current_index - 1]
  end
end
