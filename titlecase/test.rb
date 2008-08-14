require "test/unit"
require "title_case"

# To make it easy to test
class String
  include TitleCase
end

class TitleCaseTest < Test::Unit::TestCase
  def setup
    @str = ["This", "script"]
  end
  
  # Small words stay as such
  def test_small_words_within_phrase
    %w( a an and as at but by en for if in of on or the to v v. via vs vs. ).each do |word|
      
      # Test in a string
      original_str = @str.join( " #{word} " ) + "."
      assert_equal "This #{word} Script.", original_str.titlecase
      
      # Test with uppercase small word
      str = @str.join( " #{word.capitalize} " ) + "."
      assert_equal "This #{word} Script.", str.titlecase
      
    end
  end
  
  def test_small_words_at_end_of_phrase
    %w( a an and as at but by en for if in of on or the to v via vs ).each do |word|
      
      str = @str.join(" ") + " #{word}"
      assert_equal "This Script #{word.capitalize}", str.titlecase
      
    end
  end
  
  # Words that contain caps stay as such
  def test_other_than_first_character
    %w( iTunes TitleCase ).each do |word|
      assert_equal word, word.titlecase
    end
  end
  
  # Words that contain . stay as such (example.com, del.icio.us)
  def test_contain_period
    %w( example.com del.icio.us ).each do |word|
      assert_equal word, word.titlecase
    end
  end
  
  def test_small_word_after_colon
    %w( a an and as at but by en for if in of on or the to v via vs ).each do |word|
      
      str = @str.join(" ") + ": #{word} " + @str.last
      
      assert_equal "This Script: #{word.capitalize} Script", str.titlecase
      
    end
  end
  
  def test_odd_cases
    %w( AT&T Q&A ).each do |word|
      
      str = @str.join(" #{word} ")
      assert_equal "This #{word} Script", str.titlecase
      
    end
  end
  
  def test_gruber_examples
    # Taken from http://daringfireball.net/projects/titlecase/examples-edge-cases
    pass = [
      [
        "q&a with steve jobs: 'that's what happens in technology'",
        "Q&A With Steve Jobs: 'That's What Happens in Technology'"
      ],
      [
        "What Is AT&T's Problem?",
        "What Is AT&T's Problem?"
      ],
      [
        "Apple Deal With AT&T Falls Through",
        "Apple Deal With AT&T Falls Through"
      ],
      [
        "this v that",
        "This v That"
      ],
      [
        "this vs that",
        "This vs That"
      ],
      [
        "this v. that",
        "This v. That"
      ],
      [
        "this vs. that",
        "This vs. That"
      ],
      [
        "The SEC's Apple Probe: What You Need to Know",
        "The SEC's Apple Probe: What You Need to Know"
      ],
      [
        "'by the Way, small word at the start but within quotes.'",
        "'By the Way, Small Word at the Start but Within Quotes.'"
      ],
      [
        "Small word at end is nothing to be afraid of",
        "Small Word at End Is Nothing to Be Afraid Of"
      ],
      [
        "Starting Sub-Phrase With a Small Word: a Trick, Perhaps?",
        "Starting Sub-Phrase With a Small Word: A Trick, Perhaps?"
      ],
      [
        "Sub-Phrase With a Small Word in Quotes: 'a Trick, Perhaps?'",
        "Sub-Phrase With a Small Word in Quotes: 'A Trick, Perhaps?'"
      ],
      [
        'Sub-Phrase With a Small Word in Quotes: "a Trick, Perhaps?"',
        'Sub-Phrase With a Small Word in Quotes: "A Trick, Perhaps?"'
      ],
      [
        '"Nothing to Be Afraid of?"',
        '"Nothing to Be Afraid Of?"'
      ],
      [
        '"Nothing to Be Afraid Of?"',
        '"Nothing to Be Afraid Of?"'
      ],
      [
        "a thing",
        "A Thing"
      ]
    ]
    
    pass.each do |arr|
      assert_equal arr[1], arr[0].titlecase
    end
  end
  
  
end