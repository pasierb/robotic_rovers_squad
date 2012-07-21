#!/usr/bin/env ruby

Dir[ File.expand_path( File.join( File.dirname(__FILE__), %w[.. lib *.rb] ) ) ].each{ |file| require file }

class Build
	extend CommandLineParser
end

Build.run( ARGV )