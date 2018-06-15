RETURN = 0
ROUTE_CRUD = %w[Добавить Изменить]
WAGONS_CRUD = %w[Добавить Прицепить Отцепить]
STATION_CRUD = %w[Добавить Просмотреть]
TRAIN_CRUD = %w[Добавить Просмотреть Переместить поезд по маршруту]
STATION_IN_ROUTE_CRUD = %w[Добавить Удалить]
DIRECTION = %w[Вперед Назад]
LIST = %w[Станции Поезда на станции]
TYPE_FOR_SHOW = %w[Пассажирский Грузовой]
TRAIN_TYPES = {
  pass: PassengerTrain,
  cargo: CargoTrain
}
WAGON_TYPES = {
  pass: PassengerWagon,
  cargo: CargoWagon
}
MAIN_MENU = %w[
  Управлание станциями
  Управление поездами
  Управление вагонами
  Управление маршрутом
  Назначить маршрут поезду
  Занять место в вагоне
  Просмотреть список станций и список поездов на станци
]
ASK_NAME = 'Введите название > '
ASK_NUMBER = 'Введите номер > '
ASK_TYPE = 'Введите тип:'
ASK_LIST_ITEM = 'Выберите пункт из списка:'
ASK_COUNT = 'Введите количество мест/объем вагона > '
ASK_VOLUME = 'Введите объем который хотите занять > '
UNKNOWN_COMAND = 'Неизвестная команда'

NUMBER_FORMAT = /^([\w]{3}-*[\w]{2})$/
