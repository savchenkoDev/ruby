module ExceptionHandler
  protected
  def init_validate
    validate!
  rescue Exception => e
    puts "ОШИБКА: #{e.message}"
    raise e
  end
end
