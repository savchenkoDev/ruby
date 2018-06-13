class PassengerWagon < Wagon
  attr_reader :taken_places
  
  def initialize(number, places)
    @total_places = places
    @taken_places = 0
    super(number, :pass, places)
    puts "Создан вагон: № #{number}, тип: :pass, мест: #{places}"
  end

  def free_places
    @total_places - @taken_places
  end

  def take_place
    raise "Все места в вагоне уже заняты. Выберите другой вагон." if @taken_places >= @total_places
    @taken_places += 1
    puts "Вы заняли место в вагоне. Ещё #{free_places} свободных."
  end
end
