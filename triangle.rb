puts "Введите размер первой стороны треугольника..."
a = gets.chomp.to_f
puts "Введите размер второй стороны треугольника..."
b = gets.chomp.to_f
puts "Введите размер третьей стороны треугольника..."
c = gets.chomp.to_f

arr = [a, b, c]
arr.sort!

if arr[0]**2 + arr[1]**2 == arr[2]**2
    if arr.uniq.length < 3
        puts "Треугольник прямоугольный и равнобедренный"
    else
        puts "Треугольник прямоугольный"
    end
elsif arr.uniq.length == 1
    puts "Треугольник равносторонний"
else
    puts "Треугольник разносторонний, не прямоугольный"
end
