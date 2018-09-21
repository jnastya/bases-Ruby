# Documentation
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
  rescue StandardError
    false
  end

  protected

  def validate!
    raise 'Ошибка, класс не соответствует!' unless @all_stations.all? do |s|
      s.is_a?(Station)
    end

    true
  end
end
