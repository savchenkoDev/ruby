class Train
	attr_accessor :current_speed, :current_station, :detail, :number, :route
	# attr_reader

	def initialize (number, type, wagon_count)
		@detail = [number, type, wagon_count]

		@number = number
		@current_station = nil
		@route = nil
	end
#  Метод набора скорости
	def up_speed (speed)
		self.current_speed = speed
	end

	def stop
		self.current_speed = 0
	end

# Сначала думал передавать количество выгонов, но
# т.к. метод может добавлять или убирать только по одному вагону, то принимать будет команду
# и на основании ее производить действие
	def update_wagon (action)
		if current_speed != 0
			return puts "Прицепить/отцепить вагон можно только когда поезд стоит"
		end
		case action
		when 'add' then  return self.detail[2] +=1
		when 'clean' then  return self.detail[2] -=1
		end
		puts "ERROR: нет такой команды."
	end

	def get_route(route)
		self.route = route.list
		self.current_station = self.route[0]
		@current_index = 0
	end

	def move (direction)
		case direction
			when "front"
					@current_index += 1
					self.current_station = self.route[@current_index]

			when "back"
					@current_index -= 1
					self.current_station = self.route[@current_index]
			else
			self.route = nil if self. current_station = self.route.last # Когда доехали до конца маршрута обнуляем маршрут
	end
end

	def route_info (action)
		case action
			when "next" then return self.route[@current_index + 1]
			when "prev" then return self.route[@current_index - 1]
			when "current" then return self.current_station
		end
		puts "Нет такой команды"
	end
end
