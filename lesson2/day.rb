puts "Ведите число месяца..."
day = gets.chomp.to_i
puts "Введите номер месяца..."
month = gets.chomp.to_i
puts "Введите год..."
year = gets.chomp.to_i

def leap_year(y)
  return (y % 4 == 0) && !(y % 100 == 0) || (y % 400 == 0)
end

arr1 = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
arr2 = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if leap_year(year)
  current_year = arr1
else
  current_year = arr2
end

days = 0

current_year.each_with_index do |current_month_days, index|
  break if index == month-1
  days += current_month_days
end

days += day

puts "Порядковый номер даты = #{days}"
