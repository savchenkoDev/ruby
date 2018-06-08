require_relative "train.rb"
require_relative "cargo_train.rb"
require_relative "passenger_train.rb"
require_relative "route.rb"
require_relative "station.rb"
require_relative "wagon.rb"
require_relative "cargo_wagon.rb"
require_relative "passenger_wagon.rb"

class RailRoad
  attr_reader :trains, :stations, :wagons, :routes

  RETURN_COMAND = 0

  def initialize
    @stations = []
    @trains = []
    @wagons = []
    @routes = []
  end

  def seed
    @stations << Station.new("Москва")
    @stations << Station.new("Казань")
    @stations << Station.new("Екатеринбург")
    @stations << Station.new("Ростов-на-Дону")
    @stations << Station.new("Сочи")
    @trains << CargoTrain.new("cargo_train1")
    @trains << PassengerTrain.new("passenger_train1")
    @wagons << CargoWagon.new('cargo-w-1')
    @wagons << CargoWagon.new('cargo-w-2')
    @wagons << CargoWagon.new('cargo-w-3')
    @wagons << PassengerWagon.new('passenger-w-1')
    @wagons << PassengerWagon.new('passenger-w-2')
    @routes << Route.new(@stations[0], @stations[3])
    @routes << Route.new(@stations[1], @stations[3])
    @trains[0].accept_route(@routes[0])
    @trains[1].accept_route(@routes[1])
  end

  def menu
    item = get_index('Выберите действие:', [
      'Создать станцию',
      'Создать поезд',
      'Создать маршрут или управлять станциями в нем',
      'Назначать маршрут поезду',
      'Добавить вагон к поезду',
      'Отцепить вагон от поезда',
      'Перемеcтить поезд по маршруту',
      'Просматривать список станций и список поездов на станции',
      'Создать вагон',
    ])
    case item
      when 1 then create_station
      when 2 then create_train
      when 3 then manage_route
      when 4 then accept_route_to_train
      when 5 then add_wagon_to_train
      when 6 then detach_wagon_from_train
      when 7 then move_train
      when 8 then show_stations_and_trains_list
      when 9 then create_wagon
      when RETURN_COMAND then return
      else puts "Такой команды нет"
    end
  end

  def create_station
    print "Введите название станции > "
    name = gets.chomp
    stations << Station.new(name)
    puts stations.last
  end

  def create_train
    print "Введите номер поезда > "
    number = gets.chomp
    type = get_index("Выбетире тип поезда", ['Пассажирский','Грузовой'])
    case type
      when 1 then @trains << PassengerTrain.new(number)
      when 2 then @trains << CargoTrain.new(number)
      else return
    end
  end

  def create_wagon
    print "Введите номер вагона > "
    number = gets.chomp
    type = get_index("Выбетире тип вагона", ['Пассажирский','Грузовой'])
    case type
    when 1 then @wagons << PassengerWagon.new(number)
    when 2 then @wagons << CargoWagon.new(number)
    else return
    end
  end

  def manage_route
    action = get_index('Выберите действие', ['Создать маршрут','Управлять существующим'])
    case action
      when 1 then create_route
      when 2 then update_route
      else return
    end
  end

  def create_route
    station1 = get_object_by_index("Выберите начальную станцию", @stations)
    available_stations = @stations.reject { |station| station == station1 }
    station2 = get_object_by_index("Выберите конечную станцию", available_stations)
    @routes << Route.new(station1, station2)
  end

  def update_route
    route = get_object_by_index("Выберите маршрут из списка", @routes)
    return RETURN_COMAND if route == RETURN_COMAND
    action = get_index('Выберите действие:', ['Добавить станцию', 'Удалить станцию'])
    case action
      when 1 then
        avail_stat = @stations.reject { |station| route.stations.include?(station) }
        station = get_object_by_index("Выберите станцию из списка", avail_stat)
        route.add_station(station)
      when 2 then
        stations = route.stations
        avail_stat = stations.reject { |station| station == stations[0] || station == stations[-1] }
        station = get_object_by_index("Выберите станцию из списка", avail_stat)
        route.delete_station(station)
      else return
    end

  end

  def accept_route_to_train
    train = get_object_by_index("Выберите поезд из списка", @trains)
    route = get_object_by_index("Выберите маршрут из списка", @routes)
    train.accept_route(route)
  end

  def add_wagon_to_train
    train = get_object_by_index("Выберите поезд из списка", @trains)
    avail_wagons = @wagons.reject { |wagon|  wagon.type != train.type}
    wagon = get_object_by_index("Выберите вагон из списка", avail_wagons)
    train.add_wagon(wagon) if train.type == wagon.type
  end

  def detach_wagon_from_train
    train = get_object_by_index("Выберите поезд из списка", @trains)
    wagon = get_object_by_index("Выберите вагон из списка", train.wagons)
    train.unhook_wagon(wagon)
  end

  def move_train
    train = get_object_by_index("Выберите поезд из списка", @trains)
    action = get_index('Выберите направление:', ['Вперед', 'Назад'])
    case action
      when 1 then train.forward
      when 2 then train.backward
      else return
    end
  end
# Просматривать список станций и список поездов на станции
  def show_stations_and_trains_list
    action = get_index('Выберите список:', ['Станции', 'Поезда на станции'])
    case action
      when 1 then stations_list
      when 2 then trains_on_station
      else return
    end
  end

  def stations_list
    show_list('Станции:', @stations)
  end

  def trains_on_station
    station = get_object_by_index("Выберите поезд из списка", @stations)
    show_list('Поезда на станции "#{station.name}":', station.trains, false)
  end

  protected

  def get_object_by_index(intro, data_array)
    index = get_index(intro, data_array)
    return data_array[index - 1]
  end

  def get_index(intro, data_array)
    show_list(intro, data_array)
    while true
      index = gets.to_i
      exit if index == RETURN_COMAND
      return index if !data_array[index - 1].nil?
    end
  end

  def show_list(intro, data_array back = true)
    puts intro
    data_array.each_with_index { |item, index| puts "#{index + 1}. #{item}" }
    puts "#{RETURN_COMAND}. Выход" if back
    print "> "
  end
end
