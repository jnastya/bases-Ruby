class Route
  attr_reader :all_stations

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @all_stations = [start_station, end_station]
  end

  def add_mid_station(station)
    @all_stations.insert(-2, station)
  end

  def delete_station(station)
    @all_stations.delete(station)
  end

  def print_all_stations
    puts "#{@all_stations}"
  end
end
