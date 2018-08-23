class Train
  attr_accessor :speed, :current_route, :wagons
  attr_reader :type, :number

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
  end

  def increase_speed(speed)
    @speed += speed
  end

  def add_wagon(wagon)
    if speed == 0 && @type == wagon.type
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
    if step == 'forward' && (@current_route.all_stations.length-1 != @current_station_index)
      @current_station_index += 1
    elsif step == 'backward' && @current_station_index != 0
      @current_station_index -= 1
    end
  end

  def station_info
    if @current_station_index > 0
      puts "Предыдущая станция: #{@current_route.all_stations[@current_station_index-1].station_name}"
    else
      puts "Предыдущая станция: Депо"
    end

    puts "Текущая станция: #{@current_route.all_stations[@current_station_index].station_name}"

    if @current_route.all_stations.length-1 != @current_station_index
      puts "Следующая станция: #{@current_route.all_stations[@current_station_index+1].station_name}"
    else
      puts "Следующая станция: Депо"
    end
  end

  protected

  # Может быть вынесен тк в текущий момент останавливать поезд нельзя посередине
  # пути а нужно только в случае присоединения вагонов и этот метод нужно будет
  # вызвать только изнутри другого метода
  def stop
    @speed = 0
  end

end
