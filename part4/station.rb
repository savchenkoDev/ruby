class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

# Метод проверяет есть ли поезд в списке, если нет принимает его
# и устанавливает у поезде текущую станцию
  def take_train(train)
    if @trains.include?(train)
      puts 'Этот поезд уже числится на станции'
    else
      @trains << train
    end
  end

  def send_train(train)
    if @trains.include?(train)
      @trains.delete(train)
    else
      puts "Такого поезда нет на станции."
    end
  end


  def trains_by_type(type)
    @trains.select { |train| train.type == type}
  end
end
