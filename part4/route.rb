class Route
	attr_reader :list
	def initialize(start_station, finish_station)
		@list = [start_station.name, finish_station.name]
	end

	def add_inter_station (station, position =1)
		if self.list.include?(station.name)
			puts "Эта станция уже есть в маршруте."
		else
			self.list.insert(position, station.name)
		end
	end

	def delete_inter_station (station)
		self.list.delete(station) { puts "Такой станции нет в маршруте." }
	end

	def show
		self.list.each { |elem| print "#{elem} -> "}
	end

end
