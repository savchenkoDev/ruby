print "Введите коэффициент A: "
a = gets.to_f
print "Введите коэффициент B: "
b = gets.to_f
print "Введите коэффициент C: "
c = gets.to_f

discr = b**2 - 4 * a * c
puts "Дискриминант: #{discr}"
if discr < 0
  puts "Корней нет."
elsif discr == 0
  x1 = -b / (2 * a)
  puts "Корень уравнения: #{x1}"
else
  sqrt = Math.sqrt(discr)
  x1 = (-b + sqrt) / (2 * a)
  x2 = (-b - sqrt) / (2 * a)
  puts "Корни уравнения: #{x1}, #{x2}"
end
