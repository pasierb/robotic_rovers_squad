class Location

	attr_accessor :x, :y, :field

	def initialize( x , y, field = nil )
		@x = x.to_i
		@y = y.to_i
		@field = field
	end

end