all_products = {}

loop do
  puts "Введите название товара..."
  product = gets.chomp
  break if product == "stop"
  puts "Введите цену за единицу товара..."
  price = gets.chomp.to_f
  puts "Введите количество купленного товара..."
  quantity = gets.chomp.to_f
  puts "Введите stop, если хотите закончить ввод"

  all_products[product] = {'price' => price, 'quantity' => quantity}
end

puts "#{all_products}"

total = 0

all_products.each do |key, value|
  result = value["price"] * value["quantity"]
  puts " Итого за товар #{key} = #{result}"
  total += result

end

puts "Итоговая сумма Ваших покупок = #{total}"
