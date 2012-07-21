require 'test_helper'
require 'stringio'

class TestCommandLineParser < Test::Unit::TestCase

	def setup
		@args = [ "test/fixtures/sample_input.txt" ]
		@object = Class.new do
			extend CommandLineParser
		end
		@output = ""
		@object.output_stream = StringIO.new( @output, "w+" )
	end

	def test_parse_field_definition_line
		line = "5 5"
		assert @object.parse_line( line ).is_a? Field
	end

	def test_parse_rover_definition_line
		line = "3 3 E"
		assert @object.parse_line( line ).is_a? RoboticRover
	end
	
	def test_parse_file_input
		rover_1 = RoboticRover.new( 1, 2, "N" )
		rover_2 = RoboticRover.new( 3, 3, "E" )

		result = @object.parse_file( @args.first )

		assert_equal [rover_1, rover_2].collect(&:to_s), result.rovers.collect(&:to_s)
		assert_equal "LMLMLMLMM", result.commands[ result.rovers[0].id ]
		assert_equal "MMRMMRMRRM", result.commands[ result.rovers[1].id ]
	end

	def test_output
		@object.run( @args )
		assert_equal "1 3 N\n5 1 E\n", @output
	end

end