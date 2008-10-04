#!/usr/bin/env ruby
%w( rubygems linguistics ).each {|g| require g rescue puts "Error loading #{g}" and exit(1) }

unless ARGV.size == 2
	puts "USAGE: ruby num_to_words.rb <lower_bound> <upper_bound>"
	exit(1)
end

module NumExtend
	def to_word
		Linguistics::EN.numwords( self )
	end
end
class Fixnum; include NumExtend; end
class Integer; include NumExtend; end

@rev = false

# Sort them into size order
nums = [ARGV.first, ARGV.last].sort

# Figure out if they got re-ordered
@rev = true unless nums.first == ARGV.first

# Stick into a hash for some reason
@num = {
		:one => nums.first.to_i,
		:two => nums.last.to_i
}

@nums = []
(@num[:one]..@num[:two]).each do |i|
	@nums << i.to_word
end

@nums.reverse! if @rev

@nums.each { |x| puts x }
