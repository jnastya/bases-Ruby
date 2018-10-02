# Documentation
class Route
  extend Accessors
  include InstanceCounter
  include Validation

  attr_reader :all_stations
  
  validate :start_station, :type, Station
  validate :end_station, :type, Station

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    validate!
    @all_stations = [start_station, end_station]
  end

  def add_mid_station(station)
    @all_stations.insert(-2, station)
    validate!
  end

  def delete_station(station)
    @all_stations.delete(station)
  end

end
