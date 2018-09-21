# Documentation
class Station
  include InstanceCounter

  attr_accessor :all_trains
  attr_reader :station_name

  @@all_stations = []

  def self.all_stations
    @@all_stations
  end

  def initialize(station_name)
    @all_trains = []
    @station_name = station_name
    validate!
    register_instance
    @@all_stations << self
  end

  def receive_train(train)
    @all_trains << train
  end

  def trains_by_type(type)
    @all_trains.select { |train| train.type == type }
  end

  def send_train(train, step)
    @all_trains.delete(train)
    train.move(step)
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  def each_train(&block)
    @all_trains.each(&block)
  end

  protected

  def validate!
    raise 'Имя станции должно быть минимум из 3 букв' if station_name.length < 3

    true
  end
end
