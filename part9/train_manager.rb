# module
module TrainManager
  def manage_trains
    item = @interface.select_list_item(TRAIN_CRUD)
    case item
    when 0 then menu
    when 1 then create_train
    when 2 then view_train
    when 3 then move_train
    end
  end

  def create_train
    number = @interface.number_from_user
    type = @interface.type_from_user
    class_name = TRAIN_TYPES[type]
    begin
      @trains << class_name.new(number)
    rescue StandardError
      create_train
    end
    @interface.show_message "Создан поезд: № #{number}, тип: #{type}"
    @interface.waiting
  end

  def move_train
    train = @interface.user_choice(@trains, :number)
    item = @interface.select_list_item(DIRECTION)
    case item
    when 1 then train.move_forward
    when 2 then train.move_backward
    end
  end

  def view_train
    train = @interface.user_choice(@trains, :number)
    @interface.delimiter
    @interface.show_message 'Список вагонов:'
    train.each_wagon do |wagon|
      @interface.show_each_wagon(wagon)
    end
    @interface.waiting
  end
end
