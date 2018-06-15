# module
module Interface
  def show_message(message)
    puts message
  end

  def show_line(message)
    print message
  end

  def error_message(message)
    puts message
  end

  def delimiter
    puts '======================================'
  end

  def show_list(list_data)
    delimiter
    list_data.each_with_index { |item, index| puts "#{index + 1}. #{item}" }
    puts "#{RETURN}. ВЫХОД"
    print '> '
  end

  def waiting
    delimiter
    puts 'Нажмитe любую кнопку чтобы продолжить'
    delimiter
    gets
  end
end
