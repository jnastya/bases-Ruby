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
    @all_trains.each do |train|
      if train.type == type
        puts "#{train}"
      end
    end
  end

  def send_train(number)
    @all_trains.delete_if { |train| train.number == number }
  end
end


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


class Train
  attr_accessor :number, :type, :wagons, :speed, :current_route

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def increase_speed(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def manipulate_wagons(param)
    if param == 'add' && speed == 0
      @wagons += 1
    elsif param == 'remove' && speed == 0
      @wagons -= 1
    else
      puts "Поезд движется, прицепка и отцепка вагонов не возможна"
    end
  end

  def schedule(route)
    @current_route = route
    @current_station_index = 0
  end

  def move(step)
    if step == 'forward' && (@current_route.all_stations.length-1 != @current_station_index)
      @current_station_index += 1
    elsif step == 'backward' && @current_station_index != 0
      @current_station_index -= 1
    end
  end

  def station_info
    puts "Предыдущая станция: #{@current_route.all_stations[@current_station_index-1]}
          Текущая станция: #{@current_route.all_stations[@current_station_index]}
          Следующая станция #{@current_route.all_stations[@current_station_index+1]}"
  end
end
