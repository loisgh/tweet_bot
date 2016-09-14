class CheckCharacterTypes

  attr_reader :string

  def initialize(in_string)
    @string = in_string
  end

  def word_score
    ascii_alpha + digit + space + everything_else
  end

  private

  def ascii_alpha
    string =~ /[[:ascii:]][[:alpha:]]/ ? 1 : 0
  end

  def digit
    string =~ /[[:digit:]]/ ? 1 : 0
  end

  def space
    string =~ /[[:space:]]/ ? 1 : 0
  end

  def everything_else
    if string =~ /[^[:ascii:]][[:alnum:]]/ ||
       string =~ /[[:punct:]]/ ||
       string =~ /[_*!@#$%&+=|{}]/
        1
    else
        0
    end
  end
end