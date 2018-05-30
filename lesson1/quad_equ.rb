print "Введите коэффициент A: "
a= gets.chomp.to_f
print "Введите коэффициент B: "
b= gets.chomp.to_f
print "Введите коэффициент C: "
c= gets.chomp.to_f

d = b**2-4*a*c
puts "Дискриминант: #{d}"
if d<0
  puts "Корней нет."
elsif d==0
#  x1=(-b+Math.sqrt(d))/2*a}
  puts "Корень уравнения: #{(-b+Math.sqrt(d))/2*a}" # #{x1}"
else d>0
#  x1=(-b+Math.sqrt(d))/2*a
#  x2=(-b-Math.sqrt(d))/2*a
  puts "Корни уравнения: #{(-b+Math.sqrt(d))/2*a}, #{(-b-Math.sqrt(d))/2*a}" # #{x1}, #{x2}"
end
