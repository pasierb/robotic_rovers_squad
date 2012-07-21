class RoboticRover

	attr_accessor :location, :position, :field

	def initialize( x, y, position_key, field = nil )
		@location = Location.new( x, y, field )
		@position = Position.new( position_key )
		@field = field
	end

	alias :id :object_id

	def move
		temp_location = self.location.dup
		case position.to_s
		when "N"
			temp_location.y += 1
		when "S"
			temp_location.y -= 1
		when "E"
			temp_location.x += 1
		when "W"
			temp_location.x -= 1
		end
		self.location = temp_location if validate_location( temp_location )
		self
	end

	def rotate( direction )
		rotate_by = case direction
			when "L" then -1
			when "R" then 1
			else 0 end
		self.position = Position::KEYS[ Position::KEYS.rotate( rotate_by ).index( self.position.to_s ) ]
		self
	end

	def execute_command( key )
		case key
		when "M" then move
		when "L", "R" then rotate( key )
		else raise( "InvalidCommand" ) end
		self
	end

	def execute_command_list( string )
		string.each_char{|c| execute_command( c ) }
		self
	end

	def to_s
		[location.x, location.y, position.to_s].join(" ")
	end

	protected

	def validate_location( location )
		return true unless field
		field.has_coordinates?( location )
	end

	class Position

		KEYS = %w[N W S E]

		attr_accessor :key

		def initialize( key )
			@key = key
			validate_position
		end

		def to_s
			key.to_s
		end

		def key=( new_key )
			@key = new_key
			validate_position
		end

		protected

		def validate_position
			raise "InvalidPositionKey: #{key}" unless KEYS.include?( key )
			true
		end

	end

end