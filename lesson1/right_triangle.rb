=begin
  Привсаиваем значения сторонам треугольника,
  навзания не важны их мы позже поменяем.
  Так же объявляем пустую переменную для ответа
=end
sides = []
answer = ""

print "Введите первую сторону треугольника: "
sides[0] = gets.to_f
print "Введите вторую сторону треугольника: "
sides[1] = gets.to_f
print "Введите третью сторону треугольника: "
sides[2] = gets.to_f
if sides[0] > 0 || sides[1] > 0 || sides[2] > 0
  if sides[2] == sides[1] && sides[2] == sides[1]
    answer+=" равносторонний"
  elsif sides[2]**2 == sides[1]**2 + sides[0]**2
    answer+=" прямоугольный,"
    if sides[1] == sides[0]
      answer+=" равнобедренный"
    end
  else
    answer+=" не прямоугольный"
  end
  puts "Этот треугольник#{answer}."
else
  puts " ERROR:Стороны не могут быть не положительными"
end
