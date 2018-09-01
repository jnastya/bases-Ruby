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




class RailRoad

  attr_accessor :stations, :trains, :routes, :wagons

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def menu
    loop do
      puts "1. Создать станцию"
      puts "2. Создать поезд"
      puts "3. Создать маршрут"
      puts "4. Создать вагон"
      puts "5. Управлять станциями в выбранном маршруте"
      puts "6. Назначить маршрут поезду"
      puts "7. Добавить вагон к поезду"
      puts "8. Отцепить вагон от поезда"
      puts "9. Переместить поезд по маршруту вперед и назад"
      puts "10. Просмотреть список станций"
      puts "11. Просмотреть список поездов на станции"
      puts "0. Выход"
      puts "Выберите вариант..."
      choice = gets.to_i
      break if choice == 0

      case choice
      when 1
        puts "Введите название станции"
        station_name = gets.chomp
        @stations << Station.new(station_name)
      when 2
        puts "Введите номер поезда"
        number = gets.chomp
        puts "Введите тип поезда (pass или cargo)"
        type = gets.chomp
        if type == 'pass'
          @trains << PassTrain.new(number)
        elsif type == 'cargo'
          @trains << CargoTrain.new(number)
        end
      when 3
        puts "Текущие добавленные станции"
        @stations.each { |station| puts station.inspect }
        puts "Введите индекс начальной станции"
        start_station_index = gets.to_i
        puts "Введите индекс конечной станции"
        end_station_index = gets.to_i
        @routes << Route.new(@stations[start_station_index], @stations[end_station_index])
      when 4
        puts "Введите тип вагона ('pass' или 'cargo')"
        type = gets.chomp
        if type == 'pass'
          @wagons << PassWagon.new
        elsif type == 'cargo'
          @wagons << CargoWagon.new
        end
        puts "Вы создали вагоны #{@wagons}"
      when 5
        puts "Введите индекс маршрута из списка добавленных маршрутов"
        @routes.each { |route| puts route.inspect }
        user_select = gets.to_i
        route = @routes[user_select]
        puts "Введите '+' или '-' для добавления/удаления станций"
        input = gets.chomp.downcase
        if input == "+"
          puts "Введите индекс промежуточной станции из списка текущих станций, которую хотите добавить"
          @stations.each { |station| puts station.inspect }
          user_select = gets.to_i
          station = @stations[user_select]
          route.add_mid_station(station)
          puts "Ваш маршрут изменен #{route.inspect}"
        elsif input == "-"
          puts "Введите индекс промежуточной станции из списка текущих станций в маршруте, которую хотите удалить"
          puts "#{route.inspect}"
          user_select = gets.to_i
          station = @stations[user_select]
          route.delete_station(station)
          puts "Ваш маршрут изменен #{route.inspect}"
        else
          puts "Ошибка"
        end
      when 6
        puts "Введите индекс маршрута из списка добавленных маршрутов"
        @routes.each { |route| puts route.inspect }
        user_select = gets.to_i
        route = @routes[user_select]
        puts "Введите индекс поезда из списка добавленных поездов"
        @trains.each { |train| puts train.inspect }
        user_select = gets.to_i
        train = @trains[user_select]
        train.schedule(route)
        puts "Поезду #{train.inspect} назначен маршрут #{route.inspect}"
        route.all_stations[0].receive_train(train)
        puts "Поезд #{train.inspect} находится на станции #{route.all_stations[0]}"
      when 7
        puts "Введите индекс поезда из списка добавленных поездов"
        @trains.each { |train| puts train.inspect }
        user_select = gets.to_i
        train = @trains[user_select]
        puts "Введите индекс вагона, который необходимо добавить из списка добавленных вагонов"
        @wagons.each { |wagon| puts wagon.inspect }
        user_select = gets.to_i
        wagon = @wagons[user_select]
        train.add_wagon(wagon)
        puts "Текущее состояние поезда #{train.inspect}"
      when 8
        puts "Введите индекс поезда из списка добавленных поездов"
        @trains.each { |train| puts train.inspect }
        user_select = gets.to_i
        train = @trains[user_select]
        puts "Введите индекс вагона, который необходимо отцепить от поезда"
        train.wagons.each { |wagon| puts wagon.inspect }
        user_select = gets.to_i
        wagon = train.wagons[user_select]
        train.delete_wagon(wagon)
        puts "Вагон #{wagon.inspect} отцеплен от поезда #{train.inspect}"
      when 9
        puts "Введите индекс поезда из списка добавленных поездов, который Вы хотите переместить"
        @trains.each { |train| puts train.inspect }
        user_select = gets.to_i
        train = @trains[user_select]
        puts "Введите шаг forward или backward"
        step = gets.chomp
        train.move(step)
        if train.current_station_index > 0
          puts "Предыдущая станция: #{train.current_route.all_stations[train.current_station_index-1].station_name}"
        else
          puts "Предыдущая станция: Депо"
        end

        puts "Текущая станция: #{train.current_route.all_stations[train.current_station_index].station_name}"

        if train.current_route.all_stations.length-1 != train.current_station_index
          puts "Следующая станция: #{train.current_route.all_stations[train.current_station_index+1].station_name}"
        else
          puts "Следующая станция: Депо"
        end
      when 10
        puts "Список станций:"
        @stations.each { |station| puts station.inspect }
      when 11
        puts "Введите индекс станции, для просмотра поездов, находящихся на этой станции"
        @stations.each { |station| puts station.inspect }
        user_select = gets.to_i
        station = @stations[user_select]
        station.all_trains.each { |train| puts train.inspect }
      else
        puts "Ошибка. Выберите цифру из списка"
      end
    end
  end
end
