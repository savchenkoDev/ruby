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
    @interface.delimiter
    @stations << Station.new("Сочи")
    @stations << Station.new("Санкт-Петербург")
    @stations << Station.new("Нижний Новгород")
    @trains << PassengerTrain.new("qwe-34")
    @trains << CargoTrain.new("qwe-35")
    @wagons << CargoWagon.new("qwe-32")
    @wagons << PassengerWagon.new("qwe-33")
    @routes << Route.new(@stations[0], @stations[1])
    @trains[0].accept_route(@routes[0])
  end

  def menu
    loop do
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
        else
          @interface.show_message("Неизвестная команда")
          menu
      end
    end
  end

  private

  def create_station
    name = get_name_from_user(@stations)
    begin
      stations << Station.new(name)
    rescue
      create_station
    end
  end

  def create_train
    number = get_number_from_user(@trains)
    type = get_type_from_user()
    class_name = case type
    when :pass then PassengerTrain
    when :cargo then CargoTrain
    end
    begin
      @trains << class_name.new(number)
    rescue
      create_train
    end
  end

  def create_wagon
    number = get_number_from_user(@wagons)
    type = get_type_from_user()
    class_name = case type
    when :pass then PassengerTrain
    when :cargo then CargoTrain
    end
    begin
      @wagons << class_name.new(number)
    rescue
      create_wagon
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
    station1 = user_choice(@stations, :name)
    avail_stat = @stations.reject { |station| station == station1 }
    station2 = user_choice(avail_stat, :name)
    begin
      @routes << Route.new(station1, station2)
    rescue
      create_route
    end
  end

  def update_route
    route = user_choice(@routes, :title)
    item = select_list_item(STATION_CRUD)
    case item
    when 1
      avail_stat = @stations - route.stations
      station = user_choice(avail_stat, :name)
      route.add_station(station)
    when 2
      avail_stat = route.stations[1..-2]
      station = user_choice(avail_stat, :name)
      route.delete_station(station)
    end
  end

  def accept_route_to_train
    train = user_choice(@trains, :number)
    route = user_choice(@routes, :title)
    train.accept_route(route)
  end

  def add_wagon_to_train
    train = user_choice(@trains, :number)
    avail_wagons = @wagons.select { |wagon| wagon.type == train.type }
    wagon = user_choice(avail_wagons, :number)
    train.add_wagon(wagon)
  end

  def detach_wagon_from_train
    train = user_choice(@trains, :number)
    wagon = user_choice(train.wagons, :number)
    train.unhook_wagon(wagon)
  end

  def move_train
    train = user_choice(@trains, :number)
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
    @interface.show_list(@stations.map(&:name))
  end

  def trains_on_station
    station = user_choice(@stations, :name)
    trains = station.trains.map(&:number)
    @interface.show_list(trains)
  end
# ХЭЛПЕРЫ
  def get_number_from_user(data_source)
    @interface.delimiter
    @interface.show_message(ASK_NUMBER)
    number = gets.chomp
  end

  def get_name_from_user(data_source)
    @interface.delimiter
    @interface.show_message(ASK_NAME)
    name = gets.chomp
  end

  def get_type_from_user
    @interface.delimiter
    @interface.show_message(ASK_TYPE)
    @interface.show_list(TYPE)
    input = gets.to_i
    case input
    when 0 then menu
    when 1 then return :pass
    when 2 then return :cargo
    end
  end

  def select_list_item(items)
    @interface.delimiter
    @interface.show_message(ASK_LIST_ITEM)
    @interface.show_list(items)
    item = gets.to_i
    return 0 if item == RETURN
    return item if (1..items.size).cover?(item)
    @interface.error_message(UNKNOWN_COMAND)
    select_list_item(items)
  end

  def user_choice(data_source, attribute)
    item = select_list_item(data_source.map(&attribute))
    menu if item == RETURN
    data_source[item - 1]
  end
end
