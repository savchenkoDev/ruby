print  "Введите высоту треугольника: "
height = gets.to_f
print "Введите основание треугольника: "
base = gets.to_f
if height > 0 && base > 0
  square = 0.5 * height * base
  puts "Площадь треугольника равна #{square}"
else
  puts "ERROR: Числа должны быть положительными."
end
