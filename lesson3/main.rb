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
      puts "11. Просмотреть список поездов и их вагонов на станции"
      puts "12. Занять место или объем в вагоне"
      puts "13. Стартовый набор"
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
        begin
          puts "Введите номер поезда"
          number = gets.chomp
          puts "Введите тип поезда (pass или cargo)"
          type = gets.chomp
          if type == 'pass'
            @trains << PassTrain.new(number)
            puts "Создан пассажирский поезд с номером #{number}"
          elsif type == 'cargo'
            @trains << CargoTrain.new(number)
            puts "Создан грузовой поезд с номером #{number}"
          else
            raise NameError
          end
        rescue RuntimeError
          puts "Номер имеет не правильный формат"
          retry
        rescue NameError
          puts "Ошибка. Введите 'pass' или 'cargo'"
          retry
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
          puts "Введите общее кол-во мест:"
          seats_total = gets.to_i
          @wagons << PassWagon.new(seats_total)
        elsif type == 'cargo'
          puts "Введите общий объем:"
          volume_total = gets.to_f
          @wagons << CargoWagon.new(volume_total)
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
        @stations.each do |station|
          puts "- Станция #{station.station_name}"
          station.return_trains do |train|
            puts "-- Поезд: номер: #{train.number}, тип: #{train.class}, кол-во вагонов: #{train.wagons.length}"
          end
        end
      when 11
        puts "Введите индекс станции, для просмотра поездов, находящихся на этой станции"
        @stations.each_with_index { |station, index| puts "#{index}: Станция #{station.station_name}" }
        user_select = gets.to_i
        station = @stations[user_select]
        station.return_trains do |train|
          puts "-- Поезд: номер: #{train.number}"
          train.return_wagons do |wagon|
            puts "--- Номер вагона: #{wagon.number}, тип: #{wagon.class}"
            if wagon.is_a?(PassWagon)
              puts "--- Количество занятых мест: #{wagon.occupied_places}, Свободных мест: #{wagon.free_places}"
            elsif wagon.is_a?(CargoWagon)
              puts "--- Количество занятого объема: #{wagon.occupied_volume}, Свободного объема: #{wagon.free_volume}"
            end
          end
        end
      when 12
        puts "Введите индекс вагона из списка:"
        @wagons.each_with_index do |wagon, index|
          puts "#{index}: Номер вагона: #{wagon.number}, тип: #{wagon.class}"
        end
        user_select = gets.to_i
        if @wagons[user_select].is_a?(PassWagon)
          puts "В выбранном вагоне занятых мест было: #{@wagons[user_select].occupied_places}, свободных мест: #{@wagons[user_select].free_places}"
          @wagons[user_select].book_seat
          puts "Занятых мест стало: #{@wagons[user_select].occupied_places}, свободных мест: #{@wagons[user_select].free_places}"
        elsif @wagons[user_select].is_a?(CargoWagon)
          puts "В выбранном вагоне занятого объема: #{@wagons[user_select].occupied_volume}, свободного объема: #{@wagons[user_select].free_volume}"
          puts "Сколько объема добавить?"
          volume_select = gets.to_f
          @wagons[user_select].book_volume(volume_select)
          puts "Занятого объема стало: #{@wagons[user_select].occupied_volume}, свободного объема: #{@wagons[user_select].free_volume}"
        end
      when 13
        a = Station.new('Станция1')
        b = Station.new('Станция2')
        c = Station.new('Станция3')
        @stations = [a, b, c]
        d = Route.new(a, c)
        d.add_mid_station(b)
        @routes = [d]
        e = PassTrain.new('123-11')
        e.schedule(d)
        a.receive_train(e)
        f = CargoTrain.new('qwe-qe')
        f.schedule(d)
        a.receive_train(f)
        @trains = [e, f]
        i = PassWagon.new(10)
        e.add_wagon(i)
        k = CargoWagon.new(20)
        f.add_wagon(k)
        @wagons = [i, k]
      else
        puts "Ошибка. Выберите цифру из списка"
      end
    end
  end
end
