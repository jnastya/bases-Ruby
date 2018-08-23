class Station

  attr_accessor :all_trains
  attr_reader :station_name

  def initialize(station_name)
    @all_trains = []
    @station_name = station_name
  end

  def receive_train(train)
    @all_trains << train
  end

  def all_trains
    puts "На станции находятся поезда #{@all_trains}"
  end

  def trains_by_type(type)
    @all_trains.select { |train| train.type == type }
  end

  def send_train(train, step)
    @all_trains.delete(train)
    train.move(step)
  end
end
