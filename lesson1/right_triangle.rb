sides = []
answer = ""

print "Введите первую сторону треугольника: "
sides[0] = gets.to_f
print "Введите вторую сторону треугольника: "
sides[1] = gets.to_f
print "Введите третью сторону треугольника: "
sides[2] = gets.to_f

sides.sort! #сортируем массив
print sides
if sides[0] <= 0 || sides[1] <= 0 || sides[2] <= 0
  puts "ERROR: Стороны не могут быть не положительными."
  exit
end

if sides[2] == sides[1] && sides[2] == sides[0]
  puts "Этот треугольник равносторонний."
  exit
end

piph = sides[2]**2 == sides[1]**2 + sides[0]**2

if piph && sides[1] == sides[0]
  answer+="прямоугольный, равнобедренный"
elsif piph
  answer+="прямоугольный"
else
  answer+="не прямоугольный"
end
puts "Этот треугольник #{answer}."
