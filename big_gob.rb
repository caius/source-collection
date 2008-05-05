# 
#  big_gob.rb
#  Tells you who has the biggest gob from a group of twitter folk.
# 
#  USAGE: ruby big_gob.rb <username_1> <username_2> (optional: <username_3>, etc)
#  
#  Created by Caius Durling on 2008-04-06.
#  Copyright 2008 Caius Durling. All rights reserved.
# 
# Output Example:
=begin

  Julius:Desktop caius$ ruby big_gob.rb caius thehodge
  Cleansing the usernames
  Grabbing the needed data
  (This may take a while)
  Data processing complete, results forthcoming!

  Caius has the biggest gob.
  Thehodge has the smallest gob.

  Results
  -------
  Caius    	2652
  Thehodge 	2250

=end

%w( rubygems hpricot open-uri ).each { |gem| require gem }

unless ARGV.length >= 2
  puts "USAGE: ruby big_gob.rb <username_1> <username_2> (optional: <username_3>, etc)"
  exit 1
end


class Tweeter
  attr_accessor :name, :total, :page_content
  
  # Grab all the data needed for the Tweeter
  def initialize( name )
    @name = name
    get_page_content
    get_total
  end
  
  # Gets the total number of tweets
  def get_total
    # use @name to fetch total
    # Xpath is /html/body/div[2]/div[2]/div[2]/ul/li[4]/span
    doc = Hpricot( @page_content )
    @total = (doc/"/html/body/div[2]/div[4]/div/div[2]/ul/li[4]/span").html.gsub(/[^\d.]/, "").to_i
  end
  
  # Gets the HTML source of the profile page
  def get_page_content
    begin
      @page_content = open( "http://twitter.com/#{@name}" )
    rescue OpenURI::HTTPError => e
      raise "Username doesn't exist -- #{name}"
    end
  end
  
  # Returns the difference between two Tweeters' totals
  def self.range( user1, user2 )
    raise "Pass Tweeters in" unless user1.is_a?(Tweeter) && user2.is_a?(Tweeter)
    (user1.total - user2.total)
  end
  
end

puts "Cleansing the usernames"

# Make sure all the usernames are unique
ARGV.map! { |name| name.downcase }.uniq!
# We'll need this in a second
@users = []

puts "Grabbing the needed data"
puts "(This may take a while)"
# Run through the usernames to create the objects
ARGV.each do |name|
  puts "\t> Grabbing #{name}"
  @users << Tweeter.new( name )
  puts "\t> #{name} grabbed successfully!"
end

@users = @users.sort_by { |x| x.total }.reverse

puts "Data processing complete, results forthcoming!\n\n"

# Print out the results!
# First the prose.
puts "#{@users.first.name.capitalize} has the biggest gob."
puts "#{@users.last.name.capitalize} has the smallest gob."

# Pretty heading
puts "", "Results", "-------"

# figure out the longest username's length and add 4
width = @users.map { |user| user.name }.sort_by { |name| name.length }[0].length + 4

# And finally the actual totals
@users.each do |user|
  printf "%-#{width}s\t%i\n", user.name.capitalize, user.total
end

puts