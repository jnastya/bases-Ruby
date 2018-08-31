class Train

  include Manufacturer
  include InstanceCounter

  attr_accessor :speed, :current_route, :wagons, :all_trains
  attr_reader :number, :current_station_index

  @@all_trains = []

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
    @@all_trains << self
  end

  def increase_speed(speed)
    @speed += speed
  end

  def add_wagon(wagon)
    is_proper_type = ((self.class.to_s.include? "Pass") && (wagon.class.to_s.include? "Pass")) || ((self.class.to_s.include? "Cargo") && (wagon.class.to_s.include? "Cargo"))
    if speed == 0 && is_proper_type
      @wagons << wagon
    else
      puts "Прицепка вагона не возможна"
    end
  end

  def delete_wagon(wagon)
    if speed == 0
      @wagons.delete(wagon)
    else
      puts "Поезд движется, отцепка вагона не возможна"
    end
  end

  def schedule(route)
    @current_route = route
    @current_station_index = 0
  end

  def move(step)
    free_run = @current_route.all_stations.length-1 != @current_station_index
    if step == 'forward' && free_run
      @current_station_index += 1
    elsif step == 'backward' && @current_station_index != 0
      @current_station_index -= 1
    end
  end

  # def self.all_trains
  #   @@all_trains
  # end

  def self.find(number)
    @@all_trains.find { |train| train.number == number }
  end

  protected

  # Может быть вынесен тк в текущий момент останавливать поезд нельзя посередине
  # пути а нужно только в случае присоединения вагонов и этот метод нужно будет
  # вызвать только изнутри другого метода
  def stop
    @speed = 0
  end

end
