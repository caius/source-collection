#!/usr/bin/env ruby
# 
# Prints the structure of the passed class out
# 

def print_class_structure( class_in )
  return false unless class_in.is_a? Class
  @class = class_in
  puts @class.name
  i = 1
  # Because everything inherits from Object
  until @class.name == "Object"
    @class = @class.superclass
    puts "#{"\t"*i} -> #{@class.name}"
    i += 1
  end
end

# Example:
__END__
print_class_structure( RuntimeError )

>> RuntimeError
>> 	 -> StandardError
>> 		 -> Exception
>> 			 -> Object
