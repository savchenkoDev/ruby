class PassengerTrain < Train
  def initialize(number)
    super(number, :pass)
  end

  def same_type?(wagon)
    wagon.type == :pass
  end

  def add_wagon(wagon)
    return unless same_type?(wagon)
    if @current_speed == 0
      @wagons << wagon
      wagon.add_to_train(self)
    end
  end
end
