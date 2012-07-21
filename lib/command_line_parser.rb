module CommandLineParser
		
	attr_accessor :output_stream

	def run( options = ARGV )
		return output_stream.puts("Usage: #{File.basename(__FILE__)} [input_files]") if options.empty? || options.include?("--help")
		options.each do |path| 
			parsed = parse_file( path ) 
			parsed.rovers.each do |rover|
				rover.field = parsed.field
				output_stream.puts rover.execute_command_list( parsed.commands[rover.id] )
			end
		end
	end

	def parse_file( path )
		result = Struct.new( :rovers, :commands, :field ).new( [], {}, nil )
		rover_id = nil
		File.open( path ).each do |line|
			object = parse_line( line )
			case object
			when Field then result.field = object
			when RoboticRover
				rover_id = object.id
				result.rovers << object
			else result.commands[rover_id] = object
			end
		end
		result
	end

	def parse_line( line )
		array = line.split(/\s*/)
		case array.size
		when 2 then Field.new( *array.collect{ |v| v.to_i + 1 } )
		when 3 then RoboticRover.new( *array )
		else line.chomp end
	end

	def output_stream
		@output_stream ||= $stdout
	end

end