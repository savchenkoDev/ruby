# Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
answer = Hash.new
('a'..'z').to_a.each_with_index { |letter, index|
  answer[letter] = index + 1 if ["a","e","i","o","u","y"].include?(letter)
}
