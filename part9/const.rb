RETURN = 0
ROUTE_CRUD = %w[Добавить Изменить].freeze
WAGONS_CRUD = %w[Добавить Прицепить Отцепить].freeze
STATION_CRUD = %w[Добавить Просмотреть].freeze
TRAIN_CRUD = ['Добавить', 'Просмотреть', 'Переместить поезд по маршруту'].freeze
STATION_IN_ROUTE_CRUD = %w[Добавить Удалить].freeze
DIRECTION = %w[Вперед Назад].freeze
TYPE_FOR_SHOW = %w[Пассажирский Грузовой].freeze
TRAIN_TYPES = {
  pass: PassengerTrain,
  cargo: CargoTrain
}.freeze
WAGON_TYPES = {
  pass: PassengerWagon,
  cargo: CargoWagon
}.freeze
MAIN_MENU = [
  'Управлание станциями',
  'Управление поездами',
  'Управление вагонами',
  'Управление маршрутом',
  'Назначить маршрут поезду',
  'Занять место в вагоне'
].freeze
ASK_NAME = 'Введите название > '.freeze
ASK_NUMBER = 'Введите номер > '.freeze
ASK_TYPE = 'Введите тип:'.freeze
ASK_LIST_ITEM = 'Выберите пункт из списка:'.freeze
ASK_COUNT = 'Введите количество мест/объем вагона > '.freeze
ASK_VOLUME = 'Введите объем который хотите занять > '.freeze
UNKNOWN_COMAND = 'Неизвестная команда'.freeze

NUMBER_FORMAT = /^([\w]{3}-*[\w]{2})$/
