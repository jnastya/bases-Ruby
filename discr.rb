  puts "Введите коэффициент a..."
  a = gets.chomp.to_f
  puts "Введите коэффициент b..."
  b = gets.chomp.to_f
  puts "Введите коэффициент c..."
  c = gets.chomp.to_f

  d = b ** 2 - 4 * a * c
  if d < 0
    puts "Уравнение действительных решений не имеет"
  elsif d == 0
    x = - b / (2 * a)
    puts "Один корень x = #{x}"
  else d > 0
    x1 = (-b + Math.sqrt(d)) / (2 * a)
    x2 = (- b - Math.sqrt(d)) / (2 * a)
    puts "Два корня x1 = #{x1}, x2 = #{x2}"
  end
