#!/usr/bin/env ruby

# Generates a random string of length x
# using a-z A-Z 0-9

# length of the random string
LENGTH = 35

chars = ( (0..9).to_a | ('a'..'z').to_a | ('A'..'Z').to_a ).map {|x| x.to_s }

class Array
  def random_element
    self.sort_by { Kernel.rand }.first
  end
end

a = []

until a.length == LENGTH
  a << chars.random_element
end

puts a.join # => "TbN7u5GlZpKDBMxKGOLMhD27VwMOU3RcpEM"
