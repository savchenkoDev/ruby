# Class
class PassengerWagon < Wagon
  def initialize(number, amount)
    super(number, :pass, amount)
  end

  def take_volume(*arg)
    super(1)
  end
end
