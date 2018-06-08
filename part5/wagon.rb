class Wagon
  attr_reader :type
  attr_writer :train

  def initialize(number,type)
    @number = number
    @type = type
    @train = nil
  end

  def add_to_train(train)
    @train = train
  end
end
