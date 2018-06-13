class CargoWagon < Wagon
  def initialize(number, amount)
    super(number, :cargo, amount)
    puts "Создан вагон: № #{number}, тип: :cargo, объем: #{amount}"
  end

  def free_position
    @total_position - @taken_position
  end

  def overload(volume)
    return 0 if volume < 0
    @taken_position + volume > @total_position ? free_position : volume
  end
end
