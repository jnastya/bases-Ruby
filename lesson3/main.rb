require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'train_pass'
require_relative 'train_cargo'
require_relative 'wagon'
require_relative 'wagon_pass'
require_relative 'wagon_cargo'



class RailRoad

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
      puts "10. Просмотреть список станций и список поездов на станции"
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
        @trains << Train.new(number, type)
      when 3
        puts "Текущие добавленные станции"
        puts "#{@stations}"
        puts "Введите индекс начальной станции"
        start_station_index = gets.to_i
        puts "Введите индекс конечной станции"
        end_station_index = gets.to_i
        @routes << Route.new(@stations[start_station_index], @stations[end_station_index])
      when 4
        puts "Введите тип вагона"
        type = gets.chomp
        @wagons << Wagon.new(type)
        puts "Вы создали вагоны #{@wagons}"
      when 5
        puts "Введите индекс маршрута из списка добавленных маршрутов"
        puts "#{@routes}"
        user_select = gets.to_i
        route = @routes[user_select]
        puts "Введите '+' или '-' для добавления/удаления станций"
        input = gets.chomp.downcase
        if input == "+"
          puts "Введите индекс промежуточной станции из списка текущих станций, которую хотите добавить"
          puts "#{@stations}"
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
        puts "#{@routes}"
        user_select = gets.to_i
        route = @routes[user_select]
        puts "Введите индекс поезда из списка добавленных поездов"
        puts "#{@trains}"
        user_select = gets.to_i
        train = @trains[user_select]
        train.schedule(route)
        puts "Поезду #{train.inspect} назначен маршрут #{route.inspect}"
        route.all_stations[0].receive_train(train)
        puts "Поезд #{train.inspect} находится на станции #{route.all_stations[0]}"
      when 7
        puts "Введите индекс поезда из списка добавленных поездов"
        puts "#{@trains}"
        user_select = gets.to_i
        train = @trains[user_select]
        puts "Введите индекс вагона, который необходимо добавить из списка добавленных вагонов"
        puts "#{@wagons}"
        user_select = gets.to_i
        wagon = @wagons[user_select]
        train.add_wagon(wagon)
        puts "Текущее состояние поезда #{train.inspect}"
      when 8
        puts "Введите индекс поезда из списка добавленных поездов"
        puts "#{@trains}"
        user_select = gets.to_i
        train = @trains[user_select]
        puts "Введите индекс вагона, который необходимо отцепить от поезда"
        puts "#{train.wagons}"
        user_select = gets.to_i
        wagon = train.wagons[user_select]
        train.delete_wagon(wagon)
        puts "Вагон #{wagon.inspect} отцеплен от поезда #{train.inspect}"
      when 9
        puts "Введите индекс поезда из списка добавленных поездов, который Вы хотите переместить"
        puts "#{@trains}"
        user_select = gets.to_i
        train = @trains[user_select]
        puts "Введите шаг forward или backward"
        step = gets.chomp
        train.move(step)
      when 10
        puts "Введите индекс поезда из списка добавленных поездов, чтобы посмотреть список назначенных поезду станций"
        puts "#{@trains}"
        user_select = gets.to_i
        train = @trains[user_select]
        puts "Введите индекс станции из списка добавленных станций, для просмотра списка поездов, находящихся на станции"
        puts "#{@stations}"
        user_select = gets.to_i
        station = @stations[user_select]
        train.station_info
        station.all_trains
      else
        puts "Ошибка. Выберите цифру из списка"
      end
    end
  end
end
