class Interface
  attr_reader :objects

  OBJECTS = {
    action: "действие",
    station: "станцию",
    train: "поезд",
    route: "маршрут",
    type: "тип",
    wagon: "вагон",
    direction: "направление",
    list: "список"
  }
  MAIN_MENU = [
    'Добавить станцию',
    'Добавить поезд',
    'Добавить вагон',
    'Управление маршрутом',
    'Назначать маршрут поезду',
    'Добавить вагон к поезду',
    'Отцепить вагон от поезда',
    'Перемеcтить поезд по маршруту',
    'Просматривать список станций и список поездов на станции',
  ]
  CRUD = {
    "c" => "Добавить",
    "r" => "Просмотреть",
    "u" => "Изменить",
    "d" => "Удалить"
  }
  TYPE = ['Пассажирский','Грузовой']
  DIRECTION = ['Вперед','Назад']
  ACTION =[]
  LIST =['Станции','Поезда на станции']
  RETURN_COMAND = 0

  def render(action, object, data = [], crud = '')
    case action
      when "create" then input(object)
      when "select"
        select(object)
        render_list(data)
    end

  end

  def select(object)
    puts "Выберите #{OBJECTS[object]} из списка:"
  end

  def input(object)
    exp = object == :station ? "название" : "номер"
    print "Введите #{exp}> "
  end

  def render_list(data)
    data.each_with_index { |item, index| puts "#{index + 1}. #{item}" }
    puts "#{RETURN_COMAND}. Выход"
    print "> "
  end

  def get_crud_array(crud)
    return error('Неверный тип данных.') unless crud.class == String
    answer = []
    crud.each_char { |letter| answer << CRUD[letter]}
    return answer
  end

  def error_message(string)
    puts string if string.class = String
  end
end
