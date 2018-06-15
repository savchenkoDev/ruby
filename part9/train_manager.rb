# module
module TrainManager
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
    number = number_from_user
    type = type_from_user
    class_name = TRAIN_TYPES[type]
    begin
      @trains << class_name.new(number)
    rescue StandardError
      create_train
    end
    show_message "Создан поезд: № #{number}, тип: #{type}"
    waiting
  end

  def view_train
    train = user_choice(@trains, :number)
    delimiter
    show_message 'Список вагонов:'
    train.each_wagon do |wagon|
      show_message "№ #{wagon.number}, тип: #{wagon.type} места: #{wagon.free_volume}/#{wagon.taken_volume}"
    end
    waiting
  end

  def move_train
    train = user_choice(@trains, :number)
    item = select_list_item(DIRECTION)
    case item
    when 1 then train.move_forward
    when 2 then train.move_backward
    end
  end
end
