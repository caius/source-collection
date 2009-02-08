# Read the lines out of the file, splitting on ","
#  and chomping trailing \n's
lines = File.new("txt.txt").readlines.map do | line |
  line.split(",").map {|w| w.chomp }
end

# Find the length of the longest word in each line
word_lengths = (0...lines.first.length).to_a
lines.each do | line |
  line.each_with_index do | word, i |
    if word_lengths[i] < word.length
      word_lengths[i] = word.length
    end
  end
end

# Aaand finally print out what we've worked out above
lines.each do | line |
  format_str, words = [], []

  # Work out the format strings and each word for the line
  a = word_lengths.map do |x|
    i = word_lengths.index(x)    
    # [ printf_string, word_to_fill_printf ]
    ["%#{x}s", line[i]]
  end
  
  # Append all the format strings into one for the line,
  # and collect all the words into one array
  a.each do |y|
    #y[0] # format str
    #y[1] # word to fill it
    format_str << y[0]
    words << y[1]
  end
  
  # Concat the format strings array into a string, 
  # complete with newline character at the end
  format_str = format_str.join("  ") << "\n"
  
  # And then call printf with the right number of arguments
  self.send(:printf, format_str, *words)
  
end

# >>  Fred Bloggs    Manager    Male   45
# >>  Laura Smith       Cook  Female   23
# >> Debbie Watts  Professor  Female   38
