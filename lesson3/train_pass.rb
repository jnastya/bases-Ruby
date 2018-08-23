class PassengerTrain < Train
  attr_reader :type

  def initialize(number, type = "pass")
    super
  end

  def add_wagon(wagon)
    if @type == wagon.type
      super
    else
      puts "Прицепка не возможна, не соответствует тип вагона"
    end
  end
end
