# module
module StationManager
  def manage_stations
    item = select_list_item(STATION_CRUD)
    case item
    when 0 then menu
    when 1 then create_station
    when 2 then view_station
    end
  end

  def create_station
    name = name_from_user
    begin
      station = Station.new(name)
      @stations << station
    rescue StandardError
      create_station
    end
    show_message("Добавлена станция: #{station.name}")
    waiting
  end

  def view_station
    station = user_choice(@stations, :name)
    delimiter
    show_message 'Список поездов:'
    station.each_train do |t|
      show_message "№ #{t.number}, тип: #{t.type}, вагонов: #{t.wagons.size}"
    end
    waiting
  end
end
