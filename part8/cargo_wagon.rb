class CargoWagon < Wagon
  def initialize(number, amount)
    super(number, :cargo, amount)
  end

  def take_position(amount)
    super(amount)
  end
end
