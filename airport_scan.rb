#!/usr/bin/env ruby

# Scans the airwaves for the defined network
# A kind of poor mans netstumbler if you will.

total = 10
network = "SCAT-STUDENT"
found = 0

0..total.times do |i|
	a = `airport -s | grep #{network}`
	puts "#{i+1} - #{a.chomp!}"
	unless a.empty?
		found += 1
	end
end

2.times { puts ""}
puts "From #{total} searches, the network #{network} was found #{found} times (#{(found.to_f/total.to_f)*100}%)."
