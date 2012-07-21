class Field

	attr_accessor :size_x, :size_y

	def initialize( x, y )
		@size_x = x.to_i
		@size_y = y.to_i
	end

	def has_coordinates?( location )
		location.x >= 0 && location.x <= size_x-1 && location.y >= 0 && location.y <= size_y-1
	end

end