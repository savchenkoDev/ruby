def number_from_user
  delimiter
  show_line(ASK_NUMBER)
  gets.chomp
end

def type_from_user
  delimiter
  show_message(ASK_TYPE)
  show_list(TYPE_FOR_SHOW)
  input = gets.to_i
  case input
  when 0 then menu
  when 1 then return :pass
  when 2 then return :cargo
  end
end
