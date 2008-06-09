# 
#  title_case.rb
#  TitleCase
#  
#  Caius Durling
#  http://caius.name/
#  2008-05-21
# 
#  Ruby port of John Grubers Perl script: http://daringfireball.net/projects/titlecase/TitleCase.pl
#
#  Licenced under MIT Licence.
# 


module TitleCase
  attr_accessor :exceptions, :small_words  

  def titlecase
    @small_words = %w( a an and as at but by en for if in of on or the to v[.]? via vs[.]? )
    @exceptions = %w( AT&T Q&A )
    
    str = self
    str = str.split( / (?: \s ) /x ).map do |word|
      # Upcase first letter
      # NB: String#Capitalize downcases all other
      # letters which we don't want.
      # 
      # Skip words with "." in. eg: example.com, del.icio.us
      if word.scan( %r{ [[:alpha:]] [.] [[:alpha:]] }x ).empty?
        # Only if the word is lower-case letter do we upcase the first letter
        word.gsub!( %r{ \b ([[:alpha:]])([[:lower:]]*) \b }x ) { $1.upcase + $2 }
      end

      # Lowercase out list of small words
      # word.gsub( / #{SMALL_WORDS.join("|")}/x)
      word.downcase! unless word.scan( %r{ \b (?: #{@small_words.join("|") } ) \b }ix ).empty?
      word
    end.join(" ")

    # If the first word is a small word then capitalise it
    str.gsub!( %r{ \A ([[:punct:]]*) (#{@small_words.join("|")}) \b }x ) do
      b = $1
      a = $2.split("")
      a.first.upcase!
      "#{b}#{a}"
    end

    # If the last word is a small word then capitalise it
    str.gsub!( %r{ \b (#{@small_words.join("|")}) ([[:punct:]]*) \Z }x ) do
      b = $2
      a = $1.split("")
      a.first.upcase!
      "#{a}#{b}"
    end

    # If a small word follows a colon, then uppercase it
    str.gsub!( %r{ (\:[[:space:]*[:punct:]]*) ([[:alpha:]]+) \b }x ) do
      b = $1
      a = $2.split("")
      a.first.upcase!
      "#{b}#{a}"
    end

    # Special Cases
    str.gsub!( %r{ [']S \b }x, "'s" )  # 'S (To stop "Caius'S")
    # AT&T and Q&A which contain "at" and "a"
    str.gsub!( %r{ \b (#{@exceptions.join("|")}) \b }ix ) { $1.upcase! }

    str
  end
end