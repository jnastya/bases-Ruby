require_relative 'module_manufacturer'
require_relative 'module_instance'
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'train_pass'
require_relative 'train_cargo'
require_relative 'wagon'
require_relative 'wagon_pass'
require_relative 'wagon_cargo'

# Documentation
class RailRoad
  attr_accessor :stations, :trains, :routes, :wagons, :options

  @@stations = []
  @@trains = []
  @@routes = []
  @@wagons = []
  @@options = {}

  create_station = lambda do
    puts 'Введите название станции'
    station_name = gets.chomp
    @@stations.push(Station.new(station_name))
  end
  @@options[1] = create_station

  create_train = lambda do
    begin
      puts 'Введите номер поезда'
      number = gets.chomp
      puts 'Введите тип поезда (pass или cargo)'
      type = gets.chomp
      if type == 'pass'
        @@trains << PassTrain.new(number)
        puts "Создан пассажирский поезд с номером #{number}"
      elsif type == 'cargo'
        @@trains << CargoTrain.new(number)
        puts "Создан грузовой поезд с номером #{number}"
      else
        raise NameError
      end
    rescue RuntimeError
      puts 'Номер имеет не правильный формат'
      retry
    rescue NameError
      puts "Ошибка. Введите 'pass' или 'cargo'"
      retry
    end
  end
  @@options[2] = create_train

  create_route = lambda do
    puts 'Текущие добавленные станции'
    @@stations.each { |station| puts station.inspect }
    puts 'Введите индекс начальной станции'
    start_station_i = gets.to_i
    puts 'Введите индекс конечной станции'
    end_station_i = gets.to_i
    new_r = Route.new(@@stations[start_station_i], @@stations[end_station_i])
    @@routes << new_r
  end
  @@options[3] = create_route

  create_wagon = lambda do
    puts "Введите тип вагона ('pass' или 'cargo')"
    type = gets.chomp
    if type == 'pass'
      puts 'Введите общее кол-во мест:'
      seats_total = gets.to_i
      @@wagons << PassWagon.new(seats_total)
    elsif type == 'cargo'
      puts 'Введите общий объем:'
      volume_total = gets.to_f
      @@wagons << CargoWagon.new(volume_total)
    end
    puts "Вы создали вагоны #{@@wagons}"
  end
  @@options[4] = create_wagon

  manipulate_station = lambda do
    puts 'Введите индекс маршрута из списка добавленных маршрутов'
    @@routes.each { |r| puts r.inspect }
    user_select = gets.to_i
    route = @@routes[user_select]
    puts "Введите '+' или '-' для добавления/удаления станций"
    input = gets.chomp.downcase
    if input == '+'
      puts 'Введите индекс промежуточной станции, которую хотите добавить'
      @@stations.each { |s| puts s.inspect }
      user_select = gets.to_i
      station = @@stations[user_select]
      route.add_mid_station(station)
      puts "Ваш маршрут изменен #{route.inspect}"
    elsif input == '-'
      puts 'Введите индекс промежуточной станции, которую хотите удалить'
      puts route.inspect.to_s
      user_select = gets.to_i
      station = @@stations[user_select]
      route.delete_station(station)
      puts "Ваш маршрут изменен #{route.inspect}"
    else
      puts 'Ошибка'
    end
  end
  @@options[5] = manipulate_station

  assign_route = lambda do
    puts 'Введите индекс маршрута из списка добавленных маршрутов'
    @@routes.each { |r| puts r.inspect }
    user_select = gets.to_i
    route = @@routes[user_select]
    puts 'Введите индекс поезда из списка добавленных поездов'
    @@trains.each { |t| puts t.inspect }
    user_select = gets.to_i
    train = @@trains[user_select]
    train.schedule(route)
    puts "Поезду #{train.inspect} назначен маршрут #{route.inspect}"
    route.all_stations[0].receive_train(train)
    puts "Поезд #{train.inspect} находится на станции #{route.all_stations[0]}"
  end
  @@options[6] = assign_route

  attach_wagon = lambda do
    puts 'Введите индекс поезда из списка добавленных поездов'
    @@trains.each { |t| puts t.inspect }
    user_select = gets.to_i
    train = @@trains[user_select]
    puts 'Введите индекс вагона, который необходимо добавить'
    @@wagons.each { |w| puts w.inspect }
    user_select = gets.to_i
    wagon = @@wagons[user_select]
    train.add_wagon(wagon)
    puts "Текущее состояние поезда #{train.inspect}"
  end
  @@options[7] = attach_wagon

  unhook_wagon = lambda do
    puts 'Введите индекс поезда из списка добавленных поездов'
    @@trains.each { |t| puts t.inspect }
    user_select = gets.to_i
    train = @@trains[user_select]
    puts 'Введите индекс вагона, который необходимо отцепить от поезда'
    train.wagons.each { |w| puts w.inspect }
    user_select = gets.to_i
    wagon = train.wagons[user_select]
    train.delete_wagon(wagon)
    puts "Вагон #{wagon.inspect} отцеплен от поезда #{train.inspect}"
  end
  @@options[8] = unhook_wagon

  manipulate_train = lambda do
    puts 'Введите индекс поезда, который Вы хотите переместить'
    @@trains.each { |t| puts t.inspect }
    user_select = gets.to_i
    train = @@trains[user_select]
    puts 'Введите шаг forward или backward'
    step = gets.chomp
    train.move(step)
    if train.cur_stat_i > 0
      puts 'Предыдущая станция:' \
           " #{train.cur_route.all_stations[train.cur_stat_i - 1].station_name}"
    else
      puts 'Предыдущая станция: Депо'
    end

    puts 'Текущая станция:' \
         " #{train.cur_route.all_stations[train.cur_stat_i].station_name}"

    if train.cur_route.all_stations.length - 1 != train.cur_stat_i
      puts 'Следующая станция:' \
           " #{train.cur_route.all_stations[train.cur_stat_i + 1].station_name}"
    else
      puts 'Следующая станция: Депо'
    end
  end
  @@options[9] = manipulate_train

  list_of_station = lambda do
    puts 'Список станций:'
    @@stations.each do |s|
      puts "- Станция #{s.station_name}"
      s.each_train do |t|
        puts "-- Поезд: номер: #{t.number}, тип: #{t.class}," \
             " кол-во вагонов: #{t.wagons.length}"
      end
    end
  end
  @@options[10] = list_of_station

  list_of_train_and_wagon = lambda do
    puts 'Введите индекс станции, для просмотра поездов, находящихся станции'
    @@stations.each_with_index { |s, i| puts "#{i}: Станция #{s.station_name}" }
    user_select = gets.to_i
    station = @@stations[user_select]
    station.each_train do |t|
      puts "-- Поезд: номер: #{t.number}"
      train.each_wagon do |w|
        puts "--- Номер вагона: #{w.number}, тип: #{w.class}"
        if w.is_a?(PassWagon)
          puts "--- Количество занятых мест: #{w.occupied_places}," \
               " Свободных мест: #{w.free_places}"
        elsif w.is_a?(CargoWagon)
          puts "--- Количество занятого объема: #{w.occupied_volume}," \
               " Свободного объема: #{w.free_volume}"
        end
      end
    end
  end
  @@options[11] = list_of_train_and_wagon

  occupy = lambda do
    puts 'Введите индекс вагона из списка:'
    @@wagons.each_with_index do |w, index|
      puts "#{index}: Номер вагона: #{w.number}, тип: #{w.class}"
    end
    user_select = gets.to_i
    if @@wagons[user_select].is_a?(PassWagon)
      puts "Было: занятых мест: #{@@wagons[user_select].occupied_places}," \
           " свободных мест: #{@@wagons[user_select].free_places}"
      @@wagons[user_select].book_seat
      puts "Стало: занятых мест: #{@@wagons[user_select].occupied_places}," \
           " свободных мест: #{@@wagons[user_select].free_places}"
    elsif @@wagons[user_select].is_a?(CargoWagon)
      puts "Было: занятого объема: #{@@wagons[user_select].occupied_volume}," \
           " свободного объема: #{@@wagons[user_select].free_volume}"
      puts 'Сколько объема добавить?'
      volume_select = gets.to_f
      @@wagons[user_select].book_volume(volume_select)
      puts "Стало: занятого объема: #{@@wagons[user_select].occupied_volume}," \
           " свободного объема: #{@@wagons[user_select].free_volume}"
    end
  end
  @@options[12] = occupy

  def menu
    loop do
      puts %(
        1. Создать станцию
        2. Создать поезд
        3. Создать маршрут
        4. Создать вагон
        5. Управлять станциями в выбранном маршруте
        6. Назначить маршрут поезду
        7. Добавить вагон к поезду
        8. Отцепить вагон от поезда
        9. Переместить поезд по маршруту вперед и назад
        10. Просмотреть список станций
        11. Просмотреть список поездов и их вагонов на станции
        12. Занять место или объем в вагоне
        0. Выход
        Выберите вариант...
      )
      choice = gets.to_i
      break if choice.zero?

      @@options[choice].call
    end
  end
end
