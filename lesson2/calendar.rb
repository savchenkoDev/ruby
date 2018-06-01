day_in_month = [31, 28, 30, 30, 31, 30, 31, 31, 30, 31, 30, 31]
print "Введите число > "
day = gets.to_i
print "Введите месяц > "
month = gets.to_i
print "Введите год > "
year = gets.to_i
day_in_month[1] += 1 if ( year % 4 == 0 && year % 100 != 0 || year % 400 == 0 )
for i in (1..month - 1) do
  day += day_in_month[i - 1]
end
puts "День с начала года: #{day}"
