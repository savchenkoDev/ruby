print "Введите Ваше имя"
name = gets.chomp
print "Введите Ваш рост"
height = gets.to_f
weight = height - 110
if height > 0
  if weight > 0
    puts "#{name}, Ваш идеальный вес #{weight}"
  else
    puts "#{name}, Ваш вес уже оптимальный"
  end
else
  puts "ERROR: Рост не может быть не положительным."
