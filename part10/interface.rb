# module
class Interface
  def show_message(message)
    puts message
  end

  def show_line(message)
    print message
  end

  def error_message(message)
    puts message
  end

  def delimiter
    puts '======================================'
  end

  def show_list(list_data)
    delimiter
    list_data.each_with_index { |item, index| puts "#{index + 1}. #{item}" }
    puts "#{RETURN}. ВЫХОД"
    print '> '
  end

  def waiting
    delimiter
    puts 'Нажмитe <Enter> чтобы продолжить'
    delimiter
    gets
  end

  def user_choice(data_source, attribute)
    item = select_list_item(data_source.map(&attribute))
    menu if item == RETURN
    data_source[item - 1]
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

  def show_station_info(station)
    delimiter
    show_message 'Список поездов:'
    station.each_train do |train|
      show_message render_each_train_line(train)
    end
    waiting
  end

  def show_new_wagon(wagon)
    show_message render_wagon_line(wagon)
  end

  def render_wagon_line(wag)
    "Создан вагон: № #{wag.number}, #{wag.type}, объем: #{wag.total_volume}"
  end

  def show_each_wagon(wag)
    "№ #{wag.number}, #{wag.type} места: #{wag.free_volume}/#{wag.taken_volume}"
  end

  def show_each_train(train)
    "№ #{train.number}, тип: #{train.type}, вагонов: #{train.wagons.size}"
  end
end
