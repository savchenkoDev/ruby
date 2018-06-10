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
    @wagons << CargoWagon.new(1)
    @wagons << PassengerWagon.new(2)
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
      when RETURN then exit
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
    when 0 then menu
    when 1 then create_route
    when 2 then update_route
    end
  end

  def create_route
    station1 = get_from(@stations)
    avail_stat = @stations.reject { |station| station == station1 }
    station2 = get_from(avail_stat)
    @routes << Route.new(station1, station2)
  end

  def update_route
    route = get_from(@routes)
    puts route
    item = select_list_item(STATION_CRUD)
    case item
    when 1
      avail_stat = @stations.reject { |station| route.stations.include?(station) }
      station = get_from(avail_stat)
      route.add_station(station)
    when 2
      avail_stat = route.stations[1...-2]
      station = get_from(avail_stat)
      route.delete_station(station)
    end
  end

  def accept_route_to_train
    train = get_from(@trains)
    route = get_from(@routes)
    train.accept_route(route)
  end

  def add_wagon_to_train
    train = get_from(@trains)
    avail_wagons = @wagons.select { |wagon| wagon.type == train.type }
    wagon = get_from(avail_wagons)
    train.add_wagon(wagon)
  end

  def detach_wagon_from_train
    train = get_from(@trains)
    wagon = get_from(train.wagons)
    train.unhook_wagon(wagon)
  end

  def move_train
    train = get_from(@trains)
    item = select_list_item(DIRECTION)
    case item
    when 1 then train.move_forward
    when 2 then train.move_backward
    end
  end

  def show_stations_and_trains_list
    item = select_list_item(LIST)
    case item
    when 1 then stations_list
    when 2 then trains_on_station
    end
  end

  def stations_list
    @interface.show_list(@stations)
  end

  def trains_on_station
    station = get_from(@stations)
    @interface.show_list(station.trains)
  end
# ХЭЛПЕРЫ
  def get_number(data_source)
    @interface.show_message(ASK_NUMBER)
    number = gets.to_i
    return unless data_source.map(&:number).include?(number)
    @interface.error_message(WRONG_ATTR)
    get_number(data_source)
  end

  def get_name(data_source)
    @interface.show_message(ASK_NAME)
    name = gets.chomp
    return unless data_source.map(&:name).include?(name)
    @interface.error_message(WRONG_ATTR)
    get_name(data_source)
  end

  def get_type
    @interface.show_message(ASK_TYPE)
    @interface.show_list(TYPE)
    input = gets.to_i
    case input
    when 0 then menu
    when 1 then return :pass
    when 2 then return :cargo
    else
      @interface.error_message(WRONG_ATTR)
      get_type
    end
  end

  def select_list_item(items)
    @interface.show_message(ASK_LIST_ITEM)
    @interface.show_list(items)
    item = gets.to_i
    return 0 if item == RETURN
    return item if (1..items.size).cover?(item)
    select_list_item(items)
  end

  def get_from(data_source)
    item = select_list_item(data_source)
    menu if item == RETURN
    data_source[item - 1]
  end
end
