answer  = {}
total = 0
loop do
  print "Введите название товара > "
  product = gets.chomp
  break if (product == "stop" || product == "")
  answer[product] = {}
  print "Введите цену товара > "
  answer[product][:price] = gets.to_f
  print "Введите количество товара > "
  answer[product][:count] = gets.to_f
  total += answer[product][:price] * answer[product][:count]
end
answer.each do |prod|
  prod_total = prod[1][:price] * prod[1][:count]
  puts "#{prod} Сумма за товар: #{prod_total}"
end
puts "*************** ИТОГО: #{total} ***************"
