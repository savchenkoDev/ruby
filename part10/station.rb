require_relative 'instance_counter.rb'
require_relative 'validation.rb'
require_relative 'accessors.rb'

class Station
  include InstanceCounter
  include Validation
  extend Accessors

  attr_reader :name, :trains


  validate :name, :presence

  @@stations = []
  class << self
    def all
      @@stations
    end
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def each_train
    @trains.each { |train| yield(train) }
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def take_train(train)
    return if @trains.include?(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train) if @trains.include?(train)
  end
end
