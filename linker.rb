class Linker
  attr_reader :matches, :string
  @matches = Array.new

  def self.make_links( str, trunc=false, length=15 )
    @string = str
    
    # Regex adapted from http://immike.net/blog/2007/04/06/5-regular-expressions-every-web-programmer-should-know/
    url = %r{
      \b
      # Match the leading part (proto://hostname, or just hostname)
      (?:
        # http://, or https:// leading part
        (?:https?)://[-\w]+(?:\.\w[-\w]*)+
      |
        # or, try to find a hostname with more specific sub-expression
        (?i: [a-z0-9] (?:[-a-z0-9]*[a-z0-9])? \. )+ # sub domains
        # Now ending .com, etc. For these, require lowercase
        (?-i: com\b
            | edu\b
            | biz\b
            | gov\b
            | in(?:t|fo)\b # .int or .info
            | mil\b
            | net\b
            | org\b
            | [a-z][a-z]\.[a-z][a-z]\b # two-letter country code
        )
      )

      # Allow an optional port number
      (?: : \d+ )?

      # The rest of the URL is optional, and begins with /
      (?:
        /
        # The rest are heuristics for what seems to work well
        [^.!,?;"\'<>()\[\]\{\}\s\x7F-\xFF]*
        (?:
          [.!,?]+ [^.!,?;”\’<>()\[\]\{\}\s\x7F-\xFF]+
        )*
      )?
    }ix
    
    @string.scan( url ).to_a.each do |match|
      @matches << [match, Linker::linkify( match, trunc, length )]
    end
    
    # replace each URL with its link
    @matches.each do |match|
      @string.gsub!( match[0], match[1] )
    end
    @string
  end
  
  def self.linkify( str, trunc=false, length=nil )
    out = ["<a href=\"#{str}\">"]
    if trunc
      out << Linker::truncate( str, length )
    else
      out << str
    end
    out << "</a>"
    out.join
  end
  

  def self.truncate( str, length )
    str.split("")
    length -= 3
    a = length / 2
    b = []
    b << str[0..a]
    b << str[str.length-a..str.length]
    b.join("...")
  end

end

a = "This is a block of text with www.link.com links in it, and proper http://caius.name/ http://www.caius.com"

p Linker::make_links( a, true )
# >> "This is a block of text with <a href=\"www.link.com\">www.lin...nk.com</a> links in it, and proper <a href=\"http://caius.name/\">http://....name/</a> <a href=\"http://www.caius.com\">http://...us.com</a>"
