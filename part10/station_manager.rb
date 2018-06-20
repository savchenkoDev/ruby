module StationManager
  def manage_stations
    item = @interface.select_list_item(STATION_CRUD)
    case item
    when 0 then menu
    when 1 then create_station
    when 2 then view_station_info
    end
  end

  def create_station
    name = @interface.name_from_user
    begin
      station = Station.new(name)
      @stations << station
    rescue StandardError
      create_station
    end
    @interface.show_message "Добавлена станция: #{station.name}"
    @interface.waiting
  end

  def view_station_info
    station = @interface.user_choice(@stations, :name)
    @interface.show_station_info(station)
  end
end
