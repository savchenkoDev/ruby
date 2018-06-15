# Class
class PassengerTrain < Train
  def initialize(number)
    super(number, :pass)
  end

  def add_wagon(wagon)
    return unless same_type?(wagon)
    return unless @current_speed.zero?
    @wagons << wagon
    wagon.add_to_train(self)
  end

  private

  def same_type?(wagon)
    wagon.type == :pass
  end
end
