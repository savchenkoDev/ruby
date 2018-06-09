class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type}
  end

  def take_train(train)
    return if @trains.include?(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train) if @trains.include?(train)
  end
end
