# Documentation
class Station
  extend Accessors
  include InstanceCounter
  include Validation

  attr_accessor :all_trains, :station_name

  strong_attr_accessor :way, String
  attr_accessor_with_history :m1, :m2, :m3

  validate :station_name, :presence
  validate :station_name, :type, String

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

  def each_train(&block)
    @all_trains.each(&block)
  end
end
