require_relative 'interface.rb'
require_relative 'const.rb'

class Railway
  attr_reader :trains, :stations, :wagons, :routes
  include Interface
  def initialize
    @stations = []
    @trains = []
    @wagons = []
    @routes = []
  end

  def seed
    station = Station.new("Сочи")
    @stations << station
    # @stations << Station.new("Сочи")
    @stations << Station.new("Санкт-Петербург")
    @stations << Station.new("Нижний Новгород")
    @trains << PassengerTrain.new("qwe-34")
    @trains << CargoTrain.new("qwe-35")
    wagon3 = PassengerWagon.new("qwe-32", 45)
    @wagons << wagon3
    # @wagons << CargoWagon.new("qwe-32")
    wagon1 = CargoWagon.new("qwe-33", 46)
    @wagons << wagon1
    # @wagons << PassengerWagon.new("qwe-33")
    wagon2 = PassengerWagon.new("qwe-34", 45)
    @wagons << wagon2
    # @wagons << PassengerWagon.new("qwe-34")
    @routes << Route.new(@stations[0], @stations[1])
    @trains[0].accept_route(@routes[0])
    @trains[0].add_wagon(wagon1)
    @trains[0].add_wagon(wagon2)
    @trains[1].accept_route(@routes[0])
  end

  def menu
    loop do
      item = select_list_item(MAIN_MENU)
      case item
      when 1 then manage_stations
      when 2 then manage_trains
      when 3 then manage_wagons
      when 4 then manage_routes
      when 5 then accept_route_to_train
      when 6 then take_place
      when 7 then show_stations_and_trains_list
      when RETURN then exit
      else
        show_message("Неизвестная команда")
        menu
      end
    end
  end

  private

  def manage_stations
    item = select_list_item(STATION_CRUD)
    case item
    when 0 then menu
    when 1 then create_station
    when 2 then view_station
    end
  end

  def create_station
    name = get_name_from_user(@stations)
    begin
      station = Station.new(name)
      @stations << station
    rescue
      create_station
    end
    show_message("Добавлена станция: #{station.name}")
  end

  def view_station
    station = user_choice(@stations, :name)
    station.trains_list do |train|
      puts "№ #{train.number}, тип: #{train.type}, количество вагонов: #{train.wagons.size}"
    end
  end

  def manage_trains
    item = select_list_item(TRAIN_CRUD)
    case item
    when 0 then menu
    when 1 then create_train
    when 2 then view_train
    when 3 then move_train
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
    show_message "Создан поезд: № #{number}, тип: #{type}"

  end

  def view_train
    train = user_choice(@trains, :number)
    train.wagons_list do |wagon|
      case wagon.type
      when :pass
        show_message "№ #{wagon.number}, тип: #{wagon.type}, количество мест(свободно/занято): #{wagon.free_places}/#{wagon.taken_places}"
      when :cargo
        show_message "№ #{wagon.number}, тип: #{wagon.type}, объем вагона(свободно/занято): #{wagon.free_volume}/#{wagon.taken_volume}"
      end
    end
  end

  def move_train
    train = user_choice(@trains, :number)
    item = select_list_item(DIRECTION)
    case item
    when 1 then train.move_forward
    when 2 then train.move_backward
    end
  end

  def manage_wagons
    item = select_list_item(WAGONS_CRUD)
    case item
    when 0 then menu
    when 1 then create_wagon
    when 2 then add_wagon_to_train
    when 3 then detach_wagon_from_train
    end
  end

  def create_wagon
    number = get_number_from_user(@wagons)
    type = get_type_from_user()
    class_name = case type
    when :pass then PassengerWagon
    when :cargo then CargoWagon
    end
    count = get_count_from_user(@wagons)
    begin
      wagon = class_name.new(number, count)
      @wagons << wagon
    rescue Exception => e
      show_message "ОШИБКА: #{e.message}"
      create_wagon
    end
    show_message "Создан вагон: № #{wagon.number}, тип: #{wagon.type}, объем: #{wagon.total_position}"
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



  def manage_routes
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
      route = Route.new(station1, station2)
      @routes << route
    rescue Exception => e
      create_route
    end
    show_message "Создан маршрут: #{route.title}"
  end

  def update_route
    route = user_choice(@routes, :title)
    item = select_list_item(STATION_IN_ROUTE_CRUD)
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

  def take_place
    wagon = user_choice(@wagons, :number)
    begin
      case wagon.type
      when :cargo
        volume = get_volume_from_user
        wagon.take_volume(volume)
      else
        wagon.take_volume
      end
      delimiter
      show_message "Вы заняли место в вагоне. Ещё #{wagon.free_volume} свободно."
      show_message "Вагон полон." if wagon.free_volume.zero?
    rescue Exception => e
      show_message "Ошибка: #{e.message}"
      take_place
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
    show_list(@stations.map(&:name))
  end

  def trains_on_station
    station = user_choice(@stations, :name)
    trains = station.trains.map(&:number)
    show_list(trains)
  end
# ХЭЛПЕРЫ
  def get_number_from_user(data_source)
    delimiter
    show_line(ASK_NUMBER)
    number = gets.chomp
  end

  def get_count_from_user(data_source)
    delimiter
    show_line(ASK_COUNT)
    number = gets.to_i
  end

  def get_volume_from_user
    delimiter
    show_line(ASK_VOLUME)
    volume = gets.to_i
  end

  def get_name_from_user(data_source)
    delimiter
    show_line(ASK_NAME)
    name = gets.chomp
  end

  def get_type_from_user
    delimiter
    show_message(ASK_TYPE)
    show_list(TYPE)
    input = gets.to_i
    case input
    when 0 then menu
    when 1 then return :pass
    when 2 then return :cargo
    end
  end

  def select_list_item(items)
    delimiter
    show_message(ASK_LIST_ITEM)
    show_list(items)
    item = gets.to_i
    return 0 if item == RETURN
    return item if (1..items.size).cover?(item)
    error_message(UNKNOWN_COMAND)
    select_list_item(items)
  end

  def user_choice(data_source, attribute)
    item = select_list_item(data_source.map(&attribute))
    menu if item == RETURN
    data_source[item - 1]
  end
end
