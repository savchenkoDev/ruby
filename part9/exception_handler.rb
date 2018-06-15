# Module
module ExceptionHandler
  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def init_validate
    validate!
  rescue StandardError => e
    puts "ОШИБКА: #{e.message}"
    raise e
  end
end
