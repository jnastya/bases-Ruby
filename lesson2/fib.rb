arr=[];

i = 0
loop do

  if i == 0
    arr[i] = 0
  elsif i == 1
    arr[i] = 1
  else i > 1
    arr[i] = arr[i-1] + arr[i-2]
  end

 if arr[i] > 100
    arr.pop
    break
  end
  i += 1

end

puts arr
