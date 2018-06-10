require_relative 'interface.rb'
require_relative 'const.rb'

class Railway
  attr_reader :trains, :stations, :wagons, :routes




  def initialize
    @stations = []
    @trains = []
    @wagons = []
    @routes = []
    @interface = Interface.new
  end

  def seed
    @stations << Station.new("Москва")
    @stations << Station.new("Казань")
    @stations << Station.new("Екатеринбург")
    @trains << PassengerTrain.new("1")
    @wagons << CargoWagon.new('cargo-w-1')
    @wagons << PassengerWagon.new('passenger-w-1')
    @routes << Route.new(@stations[0], @stations[3])
    @trains[0].accept_route(@routes[0])
  end

  def menu
    item = select_list_item(MAIN_MENU)
    case item
      when 1 then create_station
      when 2 then create_train
      when 3 then create_wagon
      when 4 then manage_route
      when 5 then accept_route_to_train
      when 6 then add_wagon_to_train
      when 7 then detach_wagon_from_train
      when 8 then move_train
      when 9 then show_stations_and_trains_list
      when 0 then return
      else @interface.error_message(WRONG_ATTR)
    end
  end

  private

  def create_station
    name = get_name(@stations)
    stations << Station.new(name)
  end

  def create_train
    number = get_number(@trains)
    type = get_type()
    case type
      when :pass then @trains << PassengerTrain.new(number)
      when :cargo then @trains << CargoTrain.new(number)
    end
  end

  def create_wagon
    number = get_number(@wagons)
    type = get_type()
    case type
      when :pass then @trains << PassengerWagon.new(number)
      when :cargo then @trains << CargoWagon.new(number)
    end
  end

  def manage_route
    item = select_list_item(ROUTE_CRUD)
    case item
      when 1 then create_route
      when 2 then update_route
      else return
    end
  end

  def create_route
    station1 = get_station(@stations)
    available_stations = @stations.reject { |station| station == station1 }
    station2 = get_station(available_stations)
    @routes << Route.new(station1, station2)
  end

  def update_route
    route = get_route(@routes)
    item = item = select_list_item(STATION_CRUD)
    case action
      when 1
        avail_stat = @stations.reject { |station| route.stations.include?(station) }
        station = get_station(avail_stat)
        route.add_station(station)
      when 2
        stations = route.stations
        avail_stat = stations.reject { |station| station == stations[0] || station == stations[-1] }
        station = get_station(avail_stat)
        route.delete_station(station)
      else return
    end
  end

  def accept_route_to_train
    train = get_train(@trains)
    route = get_route(@routes)
    train.accept_route(route)
  end

  def add_wagon_to_train
    train = get_train(@trains)
    avail_wagons = @wagons.reject { |wagon| wagon.type != train.type }
    wagon = get_wagon(avail_wagons)
    train.add_wagon(wagon)
  end

  def detach_wagon_from_train
    train = get_train(@trains)
    wagon = get_wagon(train.wagons)
    train.unhook_wagon(wagon)
  end

  def move_train
    train = get_train(@trains)
    item = select_list_item(DIRECTION)
    case action
    when 1 then train.move_forward
    when 2 then train.move_backward
      else return
    end
  end

  def show_stations_and_trains_list
    item = select_list_item(LIST)
    case action
      when 1 then stations_list
      when 2 then trains_on_station
      else return
    end
  end

  def stations_list
    $interface.show_list(@stations)
  end

  def trains_on_station
    station = get_object_by_index(@stations)
    @interface.show_list(station.trains)
  end
# ХЭЛПЕРЫ
  def get_number(data)
    @interface.show_message(ASK_NUMBER)
    number = gets.to_i
    if data.map(&:number).include?(number)
      @interface.error_message(WRONG_ATTR)
      return get_number(data)
    end
  end

  def get_name(data)
    @interface.show_message(ASK_NAME)
    name = gets.chomp
    if data.map(&:name).include?(name)
      @interface.error_message(WRONG_ATTR)
      return get_number(data)
    end
  end

  def get_type
    @interface.show_message(ASK_TYPE)
    input = gets.to_i
    type = case input
      when 1 then :pass
      when 2 then :cargo
      else get_type
    end
  end

  def select_list_item(items)
    @interface.show_message(ASK_LIST_ITEM)
    @interface.show_list(items)
    item = gets.to_i
    return if item == RETURN
    if !items[item - 1].nil?
      return item
    else
      select_list_item(items)
    end
  end

  def get_station(data_array)
    get_object_by_index(data_array)
  end

  def get_route(data_array)
    get_object_by_index(data_array)
  end

  def get_train(data_array)
    get_object_by_index(data_array)
  end

  def get_wagon(data_array)
    get_object_by_index(data_array)
  end

  def get_object_by_index(data_array)
    index = select_list_item(data_array)
    return data_array[index - 1]
  end
end
