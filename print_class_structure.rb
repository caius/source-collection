#!/usr/bin/env ruby
# 
# Prints the structure of the passed class out
# 

def get_class_structure( class_in )
  return false unless class_in.is_a? Class
  @class = class_in
  @s = [ @class.name ]
  # Because everything inherits from Object
  until @class.name == "Object"
    @class = @class.superclass
    @s << @class.name
  end
  @s.reverse
end

def print_class_structure( class_in )
  return false unless class_in.is_a? Class
  @tree = get_class_structure( class_in )
  
  @tree.each_with_index do |classname,index|
    puts "#{"  "*index}#{"> " unless index==0} #{classname}"
  end
  
end


# Example:
print_class_structure( RuntimeError )
__END__
>> RuntimeError
>> 	 -> StandardError
>> 		 -> Exception
>> 			 -> Object
