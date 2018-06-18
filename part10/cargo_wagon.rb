# Class
class CargoWagon < Wagon
  def initialize(number, amount)
    super(number, :cargo, amount)
  end
end
