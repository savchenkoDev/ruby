=begin
  Привсаиваем значения сторонам треугольника,
  навзания не важны их мы позже поменяем.
  Так же объявляем пустую переменную для ответа
=end

print "Введите первую сторону треугольника: "
hypotenuse = gets.chomp.to_f
print "Введите вторую сторону треугольника: "
leg1 = gets.chomp.to_f
print "Введите третью сторону треугольника: "
leg2 = gets.chomp.to_f
answer = ""

# Сначала проверяем на равносторонность, если истинна пропускаем все остальные условия и показываем ответ
if hypotenuse==leg1 && hypotenuse==leg2
  answer+=" равносторонний, равнобедренный"
=begin
  Если все стороны не равны, то выбираем наибольшую сторону
  и проверяем остальные условия
=end
else
  if hypotenuse<leg1
    hypotenuse,leg1 = leg1,hypotenuse
  end
  if hypotenuse<leg2
    hypotenuse,leg2 = leg2,hypotenuse
  end
# Проверяем равнобедренность треугольника.
  if leg1==leg2 || hypotenuse==leg2 || hypotenuse==leg1
    answer+=" равнобедренный,"
  end
# Проверяем правиьность треугольника (прямоугольность) по теореме Пифагора
  if hypotenuse**2==(leg1**2+leg2**2)
    answer+=" прямоугольный."
  else
    answer+=" не прямоугольный"
  end
end
# Выводим сформированную строку
puts "Этот треугольник#{answer}."
