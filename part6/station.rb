require_relative "instance_counter.rb"

class Station
  include InstanceCounter
  attr_reader :name, :trains

  @@stations = []
  class << self
    def all
      @@stations
    end
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
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
