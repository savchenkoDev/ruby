# module
module RouteManager
  def manage_routes
    item = select_list_item(ROUTE_CRUD)
    case item
    when 0 then menu
    when 1 then create_route
    when 2 then update_route
    end
  end

  def create_route
    begin
      route = input_route_attr
      @routes << route
    rescue StandardError
      create_route
    end
    show_message "Создан маршрут: #{route.title}"
    waiting
  end

  def input_route_attr
    station1 = user_choice(@stations, :name)
    avail_stat = @stations.reject { |station| station == station1 }
    station2 = user_choice(avail_stat, :name)
    Route.new(station1, station2)
  end

  def update_route
    route = user_choice(@routes, :title)
    item = select_list_item(STATION_IN_ROUTE_CRUD)
    case item
    when 1 then add_station_to_route(route)
    when 2 then delete_station_from_route(route)
    end
  end

  def add_station_to_route(route)
    avail_stat = @stations - route.stations
    station = user_choice(avail_stat, :name)
    route.add_station(station)
  end

  def delete_station_from_route(route)
    avail_stat = route.stations[1..-2]
    station = user_choice(avail_stat, :name)
    route.delete_station(station)
  end

  def accept_route_to_train
    train = user_choice(@trains, :number)
    route = user_choice(@routes, :title)
    train.accept_route(route)
  end
end
