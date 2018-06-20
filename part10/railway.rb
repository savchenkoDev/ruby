require_relative 'interface.rb'
require_relative 'const.rb'
require_relative 'station_manager.rb'
require_relative 'train_manager.rb'
require_relative 'wagon_manager.rb'
require_relative 'route_manager.rb'

class Railway
  include StationManager
  include TrainManager
  include WagonManager
  include RouteManager

  attr_reader :trains, :stations, :wagons, :routes
  def initialize
    @stations = []
    @trains = []
    @wagons = []
    @routes = []
    @interface = Interface.new
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
      item = @interface.select_list_item(MAIN_MENU)
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
end
