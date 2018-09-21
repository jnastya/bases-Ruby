# Documentation
class Train
  include Manufacturer
  include InstanceCounter

  NUMBER_FORMAT = /^.+{3}\-*.+{2}$/

  attr_accessor :speed, :cur_route, :wagons, :all_trains
  attr_reader :number, :cur_stat_i

  @@all_trains = {}

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
    @@all_trains[self.number] = self
    validate!
  end

  def self.find(number)
    @@all_trains[number]
  end

  def increase_speed(speed)
    @speed += speed
  end

  def add_wagon(wagon)
    is_train_pass = self.class.to_s.include? 'Pass'
    is_wagon_pass = wagon.class.to_s.include? 'Pass'
    is_train_and_wagon_pass = is_train_pass && is_wagon_pass
    is_train_cargo = self.class.to_s.include? 'Cargo'
    is_wagon_cargo = wagon.class.to_s.include? 'Cargo'
    is_train_and_wagon_cargo = is_train_cargo && is_wagon_cargo
    is_proper_type = is_train_and_wagon_pass || is_train_and_wagon_cargo
    if speed.zero? && is_proper_type
      @wagons << wagon
    else
      puts 'Прицепка вагона не возможна'
    end
  end

  def delete_wagon(wagon)
    if speed.zero?
      @wagons.delete(wagon)
    else
      puts 'Поезд движется, отцепка вагона не возможна'
    end
  end

  def schedule(route)
    @cur_route = route
    @cur_stat_i = 0
  end

  def move(step)
    free_run = @cur_route.all_stations.length - 1 != @cur_stat_i
    if step == 'forward' && free_run
      @cur_stat_i += 1
    elsif step == 'backward' && @cur_stat_i != 0
      @cur_stat_i -= 1
    end
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  def each_wagon(&block)
    @wagons.each(&block)
  end

  protected

  def stop
    @speed = 0
  end

  def validate!
    raise if number !~ NUMBER_FORMAT

    true
  end
end
