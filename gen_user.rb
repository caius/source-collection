require "rubygems"
require "faker"

name = "#{Faker::Name.first_name} #{Faker::Name.last_name}"

puts "Name: #{name}"

puts "login.name: #{name.downcase.split.join(".")}"
puts "login_name##: #{name.downcase.split.join(".")}#{Faker.numerify("##")}"

puts "Passwords:"
[5, 8, 10, 15].each do |i|
	pass = (0..i).to_a.map {|x| ["?", "#"].sort_by { Kernel.rand }.first }
	puts "\tlength #{i}: #{Faker.bothify( pass.to_s )}"
end
