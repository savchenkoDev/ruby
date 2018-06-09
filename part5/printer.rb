class Printer
  attr_reader :objects

  def initialize
    @objects = {
      action: "действие",
      station: "станцию",
      train: "поезд",
      route: "маршрут",
      type: "тип",
      wagon: "вагон",
      direction: "направление",
      list: "список"
    }
  end

  def main_menu
    return [
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
  end

  def select(object)
    puts "Выберите #{@objects[object]} из списка:"
  end

  def input(object)
    word = object == :station ? "название" : "номер"
    print "Введите #{word}: "

  end

  def crud(object, action='')
    return error('Неверный тип данных.') unless action.class == String
    answer = []
    case object
      when :type then answer = ['Пассажирский','Грузовой']
      when :direction then answer = ['Вперед','Назад']
      when :list then answer = ['Станции', 'Поезда на станции']
      else
        answer << "Добавить #{@objects[object]}" if action.include?('c')
        answer << "Просмотреть #{@objects[object]}" if action.include?('r')
        answer << "Изменить #{@objects[object]}" if action.include?('u')
        answer << "Удалить #{@objects[object]}" if action.include?('d')
    end
    return answer
  end

  def error(string)
    puts string if string.class = String
  end
end
