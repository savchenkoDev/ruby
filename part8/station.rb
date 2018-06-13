require_relative "instance_counter.rb"
require_relative 'exception_handler.rb'

class Station
  include InstanceCounter
  include ExceptionHandler
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
    init_validate
    puts "Добавлена станция: #{name}"
    @@stations << self
    register_instance
  end

  def each_train(&block)
    @trains.each { |train| yield(train)}
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

  private

  def validate!
    raise "Имя не может быть пустым" if name.nil?
    raise "Имя не может состоять меньше чем из 3 символов" if name.length < 3
    raise "Такая станция уже добавлена" if @@stations.map(&:name).include?(name)
  end
end
