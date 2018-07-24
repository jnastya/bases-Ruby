arr = ('a'..'z').to_a
hash = {}
i = 0

arr.each do |el|
  i += 1
  if el =~ /[aeiouy]/
    hash[el] = i
  end
end

puts hash
