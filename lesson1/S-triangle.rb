print  "Введите высоту треугольника: "
h = gets.chomp.to_f
print "Введите основание треугольника: "
a = gets.chomp.to_f
if a>0 && b>0
  puts "Площадь треугольника равна #{0.5*h*a}"
else
  puts "ERROR: Числа должны быть положительными."
end
