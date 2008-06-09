%w( rubygems linguistics ).each {|gem| require gem rescue puts "Error loading #{gem}" and exit(1) }

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

if ARGV.first < ARGV.last
	@num = {
		:one => ARGV.first.to_i,
		:two => ARGV.last.to_i
	}
else
	@num = {
		:one => ARGV.last.to_i,
		:two => ARGV.first.to_i
	}
	@rev = true
end

@nums = []
(@num[:one]..@num[:two]).each do |i|
	@nums << i.to_word
end

@nums.reverse! if @rev

@nums.each { |x| puts x }
