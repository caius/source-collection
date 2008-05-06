#!/usr/bin/env ruby

# Prints out the last n dirs of current directory
#
# 0.3 -- Fixed bug if run in /
# 0.2 -- Fixed bug if you passed an argument in.
# 0.1 -- Initial version
# 


# The number of dirs to show in path
dirnum = (ARGV[0] || 2).to_i
# Grab current directory path and convert to array
pwd = Dir.pwd.split("/")
# Chop off the first element if its an empty string
pwd = pwd.slice( 1, pwd.length ).compact if pwd.length > 1 && pwd[0].empty?

if pwd.length > dirnum
 # The path is truncated
 puts ".../" + pwd.slice( -dirnum, dirnum).join("/")
else
 # The path is absolute
 puts "/" + pwd.join("/")
end