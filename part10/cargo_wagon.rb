# Class
class CargoWagon < Wagon
  include Validation
  NUMBER_FORMAT = /^([\w]{3}-*[\w]{2})$/

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number, amount)
    super(number, :cargo, amount)
  end
end
