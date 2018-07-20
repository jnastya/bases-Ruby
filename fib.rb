def fib(n)

  if n == 0
    return 0
  end
  if n == 1
    return 1
  end
  if n >= 2
    return fib(n-1) + (fib(n-2))
  end

end

arr = []

i = 0
loop do
  i += 1
  break if fib(i) > 100
  arr << fib(i)
end

puts arr
