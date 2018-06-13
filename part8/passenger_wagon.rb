class PassengerWagon < Wagon
  def initialize(number, amount)
    super(number, :pass, amount)
  end

  def take_position(volume)
    amount = 1
    super(amount)
  end
end
