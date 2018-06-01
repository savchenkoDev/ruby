array = [0,1]
new_elem = 1
while new_elem <= 100 do
  array.push(new_elem)
  new_elem = array[-1] + array[-2]
end
