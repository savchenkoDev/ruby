print "Введите Ваше имя"
name = gets.chomp
print "Введите Ваш рост"
height = gets.chomp.to_f
weight = height - 110
if weight>0
  puts "#{name}, Ваш идеальный вес #{weight}"
else
  puts "#{name}, Ваш вес уже оптимальный"
end
