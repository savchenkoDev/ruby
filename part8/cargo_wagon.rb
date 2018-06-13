class CargoWagon < Wagon
  attr_reader :taken_volume

  def initialize(number, volume = WAGON_VOLUME)
    @total_volume = volume
    @taken_volume = 0
    super(number, :cargo, volume)
    puts "Создан вагон: № #{number}, тип: :cargo, объем: #{volume}"

  end

  def take_volume(volume)
    raise "Объем не может быть не положительным." if volume < 0
    raise "Весь объем в вагоне уже занят. Выберите другой вагон." if @taken_volume == @total_volume
    volume = @taken_volume + volume > @total_volume ? free_volume : volume
    @taken_volume += volume
    puts "Вы заняли объем (#{volume}) в вагоне."
    puts " Вагон полон." if free_volume.zero?
  end

  def free_volume
    @total_volume - @taken_volume
  end
end
