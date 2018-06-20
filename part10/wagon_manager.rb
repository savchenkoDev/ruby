module WagonManager
  def manage_wagons
    item = @interface.select_list_item(WAGONS_CRUD)
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
    @interface.show_new_wagon(wagon)
    @interface.waiting
  end

  def input_wagon_attr
    number = @interface.number_from_user
    type = @interface.type_from_user
    class_name = WAGON_TYPES[type]
    count = @interface.count_from_user
    class_name.new(number, count)
  end

  def add_wagon_to_train
    train = @interface.user_choice(@trains, :number)
    avail_wagons = @wagons.select { |wagon| wagon.type == train.type }
    wagon = @interface.user_choice(avail_wagons, :number)
    train.add_wagon(wagon)
  end

  def detach_wagon_from_train
    train = @interface.user_choice(@trains, :number)
    wagon = @interface.user_choice(train.wagons, :number)
    train.unhook_wagon(wagon)
  end

  def take_place
    volume = 1
    wagon = @interface.user_choice(@wagons, :number)
    volume = @interface.volume_from_user if wagon.type == :cargo
    wagon.take_volume(volume)
    @interface.delimiter
    @interface.show_message "Вы заняли место в вагоне. Ещё #{wagon.free_volume} свободно."
    @interface.show_message 'Вагон полон.' if wagon.free_volume.zero?
  end
end
