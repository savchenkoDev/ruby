answer = {}
vowels = "aeiouy".to_a # можно метод to_a не использовать, но раз уж начал с массивом, то надо до конца)))
('a'..'z').each.with_index(1) do |letter, index|
  answer[letter] = index if vowels.include?(letter)
end

print answer
