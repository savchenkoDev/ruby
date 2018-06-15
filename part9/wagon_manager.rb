# module
module WagonManager
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
    begin
      wagon = input_wagon_attr
      @wagons << wagon
    rescue StandardError
      create_wagon
    end
    show_new_wagon(wagon)
    waiting
  end

  def input_wagon_attr
    type = type_from_user
    number = number_from_user
    class_name = WAGON_TYPES[type]
    count = count_from_user
    class_name.new(number, count)
  end

  def show_new_wagon(wagon)
    show_message "Создан вагон: № #{wagon.number},
                  тип: #{wagon.type},
                  объем: #{wagon.total_volume}"
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
end
