class PassengerWagon < Wagon
  def initialize(number, amount)
    super(number, :pass, amount)
    puts "Создан вагон: № #{number}, тип: :pass, мест: #{amount}"
  end

  def free_position
    @total_position - @taken_position
  end
end
