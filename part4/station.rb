class Station
	attr_reader :name
	attr_accessor :train_list # Геттер и сеттер для списка поездов на станции

	def initialize(name, train_list = [])
		@name = name
		@train_list = train_list
	end

# Метод проверяет есть ли поезд в списке, если нет принимает его
# и устанавливает у поезде текущую станцию
	def take_train (train)
		if self.train_list.include?(train.number)
			puts 'Этот поезд уже числится на станции'
		else
			self.train_list <<  train.detail
			train.current_station = self.name
		end
	end

	def send_train (train)
		if self.train_list.include?(train)
			self.train_list.delete(train.number)
		else
			puts "Такого поезда нет на станции."
		end
	end

# Список поездов по типу
	def list_by_type (type)
		self.train_list.each {|elem| puts elem if elem[1] == type}
	end
end
