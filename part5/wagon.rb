class Wagon
  attr_reader :type, :number
  attr_accessor :train

  def initialize(number,type)
    @number = number
    @type = type
  end

  def add_to_train(train)
    @train = train
  end
end
