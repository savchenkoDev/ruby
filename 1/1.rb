# def station_messages(message)
#   case message
#     when :new_station then print "Введите название станции > "
#     when :select_station then puts "Выберите станцию из списка:"
#   end
# end
#
# def train_messages(message)
#   case message
#     when :new_train then print "Введите номер поезда > "
#     when :select_train then puts "Выберите поезд из списка:"
#   end
# end
#
# def wagon_messages(message)
#   case message
#     when :new_wagon then print "Введите номер вагона > "
#     when :select_wagon then puts "Выберите вагон из списка:"
#   end
# end
#
# def route_messages(message)
#   case message
#     when :action then puts "Выберите действие:"
#     when :select_route then puts "Выберите маршрут из списка:"
#     when :start_station then puts "Выберите начальную станцию: "
#     when :start_station then puts "Выберите конечную станцию: "
#     when :route_crud then return crud(:route, 'cu')
#     else puts "Такой команды нет."
#   end
# end
#
# def type_message(message)
#   case message
#     when :select_type then puts "Выбeрите тип:"
#     when :type_crud then return ['Пассажирский','Грузовой']
#   end
# end
#
# def app_message(message)
#   case message
#     when :select_action then puts "Выбeрите пункт меню:"
#     when :main_menu
#       return [
#         'Добавить станцию',
#         'Добавить поезд',
#         'Добавить вагон',
#         'Управление маршрутом',
#         'Назначать маршрут поезду',
#         'Добавить вагон к поезду',
#         'Отцепить вагон от поезда',
#         'Перемеcтить поезд по маршруту',
#         'Просматривать список станций и список поездов на станции',
#       ]
#   end
# end
