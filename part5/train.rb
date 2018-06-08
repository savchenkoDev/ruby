class Train
  attr_reader :current_speed, :number, :route, :type
  attr_accessor :wagons

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @current_speed = 0
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
    @wagons << wagon if @current_speed == 0
    wagon.add_to_train(self)
  end

  def unhook_wagon(wagon)
    @wagons.delete(wagon)
    wagon.train = nil
  end

  def forward
    return unless next_station
    current_station.send_train(self)
    next_station.take_train(self)
    @current_index += 1
  end

  def backward
    return unless prev_station
    current_station.send_train(self)
    prev_station.take_train(self)
    @current_index -= 1
  end

  protected
# Методы скорости в protected, потому что станция и маршрут не должны управлять
# скоростью или вагонами. Значит делать их публичными неправильно

  def speed_ud(speed)
    @current_speed += speed
  end

  def speed_down(speed)
    @current_speed -= speed
    @current_speed = 0 if @current_speed.negative?
  end
end
