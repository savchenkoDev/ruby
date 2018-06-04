print "Введите Ваше имя"
name = gets.chomp
print "Введите Ваш рост"
height = gets.to_f
weight = height - 110

# Если рост не положительный, то прерываем программу т.к. считать что-то не имеет смысла
# так же как в задаче с прямоугольным треугольником

if height > 0
  puts "ERROR: Рост не может быть не положительным."
  exit
end

if weight > 0
  puts "#{name}, Ваш идеальный вес #{weight}"
else
  puts "#{name}, Ваш вес уже оптимальный"
end
