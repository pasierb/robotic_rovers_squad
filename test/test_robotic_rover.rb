require 'test_helper'

class TestRoboticRover < Test::Unit::TestCase

	def setup
		@rover = RoboticRover.new( 3, 3, "N" )
    @field = Field.new( 5, 5 )
    @rover.field = @field
	end

  def test_should_raise_an_error_when_invalid_position_provided
  	assert_raise RuntimeError do
  		rover = RoboticRover.new( 3, 5, "R" )
  	end	
  end

  def test_change_position
  	target_position = "S"
  	@rover.position = target_position
  	assert_equal target_position, @rover.position.to_s
  end

  def test_change_to_invalid_position
  	target_position = "D"
  	assert_raise RuntimeError do
  		@rover.position.key = target_position
  	end
  end

  def test_move_north
  	@rover.move
  	assert_equal 4, @rover.location.y
  end

  def test_move_south
  	@rover.position = "S"
  	@rover.move
  	assert_equal 2, @rover.location.y
  end

  def test_move_east
  	@rover.position = "E"
  	@rover.move
  	assert_equal 4, @rover.location.x
  end

  def test_move_west
  	@rover.position = "W"
  	@rover.move
  	assert_equal 2, @rover.location.x
  end

  def test_rotate_left_facing_north
    assert_rotation( "N", "W", "L" )
  end

  def test_rotate_left_facing_east
    assert_rotation( "E", "N", "L" )
  end

  def test_rotate_left_facing_south
    assert_rotation( "S", "E", "L" )
  end

  def test_rotate_left_facing_west
    assert_rotation( "W", "S", "L" )
  end

  def test_rotate_right_facing_north
    assert_rotation( "N", "E", "R" )
  end

  def test_rotate_right_facing_east
    assert_rotation( "E", "S", "R" )
  end

  def test_rotate_right_facing_south
    assert_rotation( "S", "W", "R" )
  end

  def test_rotate_right_facing_west
    assert_rotation( "W", "N", "R" )
  end

  def test_move_out_of_boundries_y_axis_minus
    rover = RoboticRover.new( 0, 0, "S", @field )
    rover.move
    assert_equal 0, rover.location.y
  end

  def test_move_out_of_boundries_x_axis_minus
    rover = RoboticRover.new( 0, 0, "W", @field )
    rover.move
    assert_equal 0, rover.location.x
  end

  def test_print_output
    rover = RoboticRover.new( 2, 4, "W" )
    assert_equal "2 4 W", rover.to_s
  end

  def test_sample_input_1
  	rover = RoboticRover.new( 1, 2, "N" )
  	moves = %w[L M L M L M L M M]
  	moves.each do |move|
  		rover.execute_command( move )
  	end
  	assert_equal 1, rover.location.x
  	assert_equal 3, rover.location.y
  	assert_equal "N", rover.position.to_s
  end

  def test_sample_input_2
  	rover = RoboticRover.new( 3, 3, "E" )
  	moves = %w[M M R M M R M R R M]
  	moves.each do |move|
  		rover.execute_command( move )
  	end
  	assert_equal 5, rover.location.x
  	assert_equal 1, rover.location.y
  	assert_equal "E", rover.position.to_s
  end

  def assert_rotation( starting_position, target_position, rotation )
    @rover.position = starting_position
    assert_equal starting_position, @rover.position.to_s
    @rover.rotate( rotation )
    assert_equal target_position, @rover.position.to_s
  end

end