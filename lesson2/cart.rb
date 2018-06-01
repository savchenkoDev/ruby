answer  = {}
total = 0
loop do
  print "Введите название товара > "
  product = gets.chomp
  break if (product == "stop" || product == "" )
  answer.store( product, {} )
  print "Введите цену товара > "
  answer[product][:price] = gets.to_f
  print "Введите количество товара > "
  answer[product][:count] = gets.to_f
end
answer.each do |key, value|
  prod_total = value[:price] * value[:count]
  total += prod_total
  puts "#{key}: #{value} Сумма за товар: #{prod_total}"
end
puts "*************** ИТОГО: #{total} *************"
