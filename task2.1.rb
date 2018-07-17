puts "Как тебя зовут?"
name = gets.chomp

puts "Введите Ваш рост"
height = gets.chomp

ideal_weight = "#{height.to_i - 110}"
if ideal_weight.to_i > 0
    puts "#{name}, Ваш идеальный вес = #{height.to_i - 110} кг"
else
    puts "#{name}, Ваш вес уже оптимальный"
end
