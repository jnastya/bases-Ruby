puts "Введите размер первой стороны треугольника..."
a = gets.chomp.to_f
puts "Введите размер второй стороны треугольника..."
b = gets.chomp.to_f
puts "Введите размер третьей стороны треугольника..."
c = gets.chomp.to_f

arr = [a, b, c]
arr.sort!
is_triange = arr[0]**2 + arr[1]**2 == arr[2]**2
is_isosceles = arr.uniq.length == 2
is_equilateral = arr.uniq.length == 1

if is_triange
  puts "Треугольник прямоугольный"
elsif is_isosceles
  puts "Треугольник равнобедренный"
elsif is_equilateral
  puts "Треугольник равносторонний"
else
  puts "Треугольник разносторонний, не прямоугольный"
end
