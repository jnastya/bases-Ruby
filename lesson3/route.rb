class Route

  include InstanceCounter

  attr_reader :all_stations

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @all_stations = [start_station, end_station]
    validate!
  end

  def add_mid_station(station)
    @all_stations.insert(-2, station)
    validate!
  end

  def delete_station(station)
    @all_stations.delete(station)
  end

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    @all_stations.each do |station|
      raise "Ошибка, класс не соответствует!" if station.class != Station
    end
    true
  end
end
