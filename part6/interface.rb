class Interface
  def show_message(message)
    puts message
  end

  def error_message(message)
    puts message
  end

  def show_list(list_data)
    list_data.each_with_index { |item, index| puts "#{index + 1}. #{item}"  }
    puts "#{RETURN}. ВЫХОД"
    print "> "
  end
end
