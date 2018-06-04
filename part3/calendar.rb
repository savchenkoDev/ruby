print "Введите число > "
day = gets.to_i
print "Введите месяц > "
month = gets.to_i
print "Введите год > "
year = gets.to_i
february = year % 4 == 0 && year % 100 != 0 || year % 400 == 0 ? 29 : 28
day_in_month = [31, february, 30, 30, 31, 30, 31, 31, 30, 31, 30, 31]
day_in_month.take(month - 1).each { |elem| day += elem}

# for i in (1..month - 1) do
#   day += day_in_month[i - 1]
# end
puts "День с начала года: #{day}"
