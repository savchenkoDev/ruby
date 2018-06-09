require_relative 'printer.rb'

class Railway
  attr_reader :trains, :stations, :wagons, :routes

  RETURN_COMAND = 0

  def initialize
    @stations = []
    @trains = []
    @wagons = []
    @routes = []
    @printer = Printer.new
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
    item = get_index(@printer.select(:action), @printer.main_menu)
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
      when RETURN_COMAND then return
      else @orinter.error("Такой команды нет.")
    end
  end

  private

  def create_station
    @printer.input(:station)
    name = gets.chomp
    stations << Station.new(name)
  end

  def create_train
    @printer.input(:train)
    number = gets.chomp
    return if @trains.count { |train| train.number == number} > 0
    type = get_index(@printer.select(:type), TYPE)
    case type
      when 1 then @trains << PassengerTrain.new(number)
      when 2 then @trains << CargoTrain.new(number)
      else return
    end
  end

  def create_wagon
    @printer.input(:wagon)
    number = gets.chomp
    type = get_index(@printer.input(:type), @printer.crud(:type))
    case type
      when 1 then @wagons << PassengerWagon.new(number)
      when 2 then @wagons << CargoWagon.new(number)
      else return
    end
  end

  def manage_route
    action = get_index(@printer.select(:action), @printer.crud(:route, 'cu'))
    case action
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
    action = get_index(@printer.select(:action), @printer.crud(:station, 'cd'))
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
    action = get_index(@printer.select(:direction), @printer.crud(:direction))
    case action
    when 1 then train.move_forward
    when 2 then train.move_backward
      else return
    end
  end

  def show_stations_and_trains_list
    action = get_index(@printer.select(:list), @printer.crud(:list))
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
    station = get_object_by_index(@stations)
    show_list('Поезда на станции "#{station.name}":', station.trains, false)
  end
# ХЭЛПЕРЫ
  def get_station(data_array)
    get_object_by_index(@printer.select(:station), data_array)
  end

  def get_route(data_array)
    get_object_by_index(@printer.select(:route), data_array)
  end

  def get_train(data_array)
    get_object_by_index(@printer.select(:train),  data_array)
  end

  def get_wagon(data_array)
    get_object_by_index(@printer.select(:wagon), data_array)
  end

  def get_index(intro, data_array)
    show_list(intro, data_array)
    while true
      index = gets.to_i
      exit if index == RETURN_COMAND
      if !data_array[index - 1].nil?
        return index
      else
        puts "Такой команды нет."
      end
    end
  end

  def get_object_by_index(intro, data_array)
    index = get_index(intro, data_array)
    return data_array[index - 1]
  end

  def show_list(intro, data_array, back = true)
    puts intro
    data_array.each_with_index { |item, index| puts "#{index + 1}. #{item}" }
    puts "#{RETURN_COMAND}. Выход" if back
    print "> "
  end
end
