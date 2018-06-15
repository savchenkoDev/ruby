require_relative 'interface.rb'
require_relative 'const.rb'
require_relative 'station_manager.rb'
require_relative 'train_manager.rb'
require_relative 'wagon_manager.rb'
require_relative 'route_manager.rb'
# class
class Railway
  include StationManager
  include TrainManager
  include WagonManager
  include RouteManager
  include Interface

  attr_reader :trains, :stations, :wagons, :routes
  def initialize
    @stations = []
    @trains = []
    @wagons = []
    @routes = []
  end

  def seed
    @stations << Station.new('Сочи')
    @stations << Station.new('Нижний Новгород')
    @trains << PassengerTrain.new('qwe-34')
    @wagons << CargoWagon.new('rty-33', 67)
    wagon = PassengerWagon.new('rty-34', 45)
    @wagons << wagon
    @routes << Route.new(@stations[0], @stations[1])
    @trains[0].accept_route(@routes[0])
    @trains[0].add_wagon(wagon)
  end

  def menu
    loop do
      item = select_list_item(MAIN_MENU).to_s
      case item
      when 1 then manage_stations
      when 2 then manage_trains
      when 3 then manage_wagons
      when 4 then manage_routes
      when 5 then accept_route_to_train
      when 6 then take_place
      when RETURN then exit
      end
    end
  end

  private

  def take_place
    volume = 1
    wagon = user_choice(@wagons, :number)
    volume = volume_from_user if wagon.type == :cargo
    wagon.take_volume(volume)
    delimiter
    show_message "Вы заняли место в вагоне. Ещё #{wagon.free_volume} свободно"
    show_message 'Вагон полон.' if wagon.free_volume.zero?
  end

  # Helpers

  def number_from_user
    delimiter
    show_line(ASK_NUMBER)
    gets.chomp
  end

  def type_from_user
    delimiter
    show_message(ASK_TYPE)
    show_list(TYPE_FOR_SHOW)
    input = gets.to_i
    case input
    when 0 then menu
    when 1 then return :pass
    when 2 then return :cargo
    end
  end

  def count_from_user
    delimiter
    show_line(ASK_COUNT)
    gets.to_i
  end

  def volume_from_user
    delimiter
    show_line(ASK_VOLUME)
    gets.to_i
  end

  def name_from_user
    delimiter
    show_line(ASK_NAME)
    gets.chomp
  end

  def select_list_item(items)
    delimiter
    show_message(ASK_LIST_ITEM)
    show_list(items)
    item = gets.to_i
    return 0 if item == RETURN
    return item if (1..items.size).cover?(item)
    select_list_item(items)
  end

  def user_choice(data_source, attribute)
    item = select_list_item(data_source.map(&attribute))
    menu if item == RETURN
    data_source[item - 1]
  end
end
