require_relative 'validation.rb'
# Class
class PassengerWagon < Wagon
  include Validation

  NUMBER_FORMAT = /^([\w]{3}-*[\w]{2})$/

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  def initialize(number, amount)
    super(number, :pass, amount)
  end

  def take_volume
    super(1)
  end
end
