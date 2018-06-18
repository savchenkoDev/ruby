# Class
class CargoTrain < Train
  include Validation
  NUMBER_FORMAT = /^([\w]{3}-*[\w]{2})$/

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  def initialize(number)
    super(number, :cargo)
  end

  def add_wagon(wagon)
    return unless same_type?(wagon)
    return unless @current_speed.zero?
    @wagons << wagon
    wagon.add_to_train(self)
  end

  private

  def same_type?(wagon)
    wagon.type == :cargo
  end
end
