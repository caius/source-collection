unless ARGV[0]
  puts "Fatal Error: you forgot to pass a file in"
  @filename = "foo.txt"
  # exit(0)
else
  @filename = ARGV[0]
end

@file = File.expand_path( @filename )

unless File.exists?( @file )
  puts "Fatal Error: File not found"
end

@sorted_lines = []

File.open( @file, "r" ).readlines.each do |line|
  @sorted_lines << line unless @sorted_lines.include?( line )
end

File.open( @file, "w" ) do |f|
  f.puts @sorted_lines
end
