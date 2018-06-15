# Class
class CargoTrain < Train
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
