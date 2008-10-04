#!/usr/bin/env ruby

# This will be fun to write in C

# Increases the letter passed in according to chars
def increment( letter, chars = ('a'..'z').to_a )
  if pos = chars.index( letter.to_s )
    pos + 1 == chars.length ? pos = 0 : pos += 1
    return chars[pos]
  end
  false
end

# Increments the current string
def increase( str, chars = ('a'..'z').to_a )
  arr = str.split("")
  arr[-1] = increment( arr[-1], chars )
  i = -1
  while arr[i] == chars.first
    i -= 1
    unless arr.values_at( i ).first.nil?
      arr[i] = increment( arr[i], chars )
    else
      arr.insert(0, chars.first)
      break
    end
  end
  arr.join
end


["a", "az", "azz", "zzz"].each do |str|
  puts "#{str} ---> #{increase(str)} <---> #{str.succ} ==== #{increase(str) == str.succ}"
end