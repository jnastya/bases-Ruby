arr = []

arr=[0, 1]

loop do
  arr <<  arr[-1] + arr[-2]
  if arr[-1] > 100
    arr.pop
    break
  end
end

puts arr
