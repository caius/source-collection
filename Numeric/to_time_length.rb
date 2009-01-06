class Numeric
  
  #
  # Converts an integer of seconds to days, hours, minutes + seconds
  # 
  # eg: 4200.to_time_length #=> "0 days 1 hours 10 mins and 0 secs"
  # 
  # Pass false to get the entire string returned, otherwise all
  # leading empty values are trimmed
  #
  def to_time_length( trim_string = true)
    amount = self.to_i
    other = 0

    a = [["sec", 60], "and",["min", 60], ["hour", 24], ["day", 7], ["week", 52]].map do |j|
      # Skip "and"
      next(j) if j.is_a? String
      # Work out the math
      i = j.last
      if amount >= i
        amount, other = amount.divmod(i)
        r = other
      else
        r = amount
        amount = 0
      end
      # And build/return the string
      "#{r} #{j.first}#{"s" unless r == 1}#{"," unless %w(sec min).include?(j.first)}"
    end.reverse.join(" ")

    # Trim the string if needed
    if trim_string && m = a[/^(0 \w+, (?:and )?)+/]
      a.gsub!(m, "")
    end

    a
  end
end


## Examples

=begin

  (Time.now - (Time.now - 500)).to_time_length
  # => "8 mins and 19 secs"

  (Time.now - (Time.now - 500)).to_time_length( false )
  # => "0 weeks, 0 days, 0 hours, 8 mins and 20 secs"

=end