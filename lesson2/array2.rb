array = [0,1]
while array.last <= 100 do
  break if (array[-1] + array[-2] ) > 100
  array.push(array[-1] + array[-2])
end
