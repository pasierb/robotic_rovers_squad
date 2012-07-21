require 'test_helper'

class TestField < Test::Unit::TestCase

	def setup
		@field = Field.new( 5, 5 )
	end

	def test_has_coordinates
		location = Location.new( 3, 3 )
		assert @field.has_coordinates?( location )
	end

	def test_has_coordinates_minus_x
		location = Location.new( -1, 0 )
		assert !@field.has_coordinates?( location )
	end

	def test_has_coordinates_minus_y
		location = Location.new( 0, -1 )
		assert !@field.has_coordinates?( location )
	end

	def test_has_coordinates_plus_x
		location = Location.new( 6, 0 )
		assert !@field.has_coordinates?( location )
	end

	def test_has_coordinates_plus_y
		location = Location.new( 0, 6 )
		assert !@field.has_coordinates?( location )
	end

	def test_has_coordinates_border_x
		location = Location.new( 4, 0 )
		assert @field.has_coordinates?( location )
		location.x = 5
		assert !@field.has_coordinates?( location )
	end

end
