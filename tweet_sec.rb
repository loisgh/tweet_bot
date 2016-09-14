class TweetSec < Struct.new(:string)

  PASSWORD_STRENGTH =  {
    (50..150) => 'Congratulations on your strong password',
        (10..49) => 'medium',
        (0..9) => 'weak'
  }

  def run
     PASSWORD_STRENGTH[find_range()]
  end

  private
  def find_range()
    return 0..9 if (0..9).include? password_strength
    return 10..49 if (10..49).include? password_strength
    return 50..150 if (50..150).include? password_strength
  end

  def password_strength
    replace_english_words_length * word_score
  end

  def replace_english_words
    ReplaceEnglishWords.new(string)
  end

  def replace_english_words_length
    replace_english_words.length
  end

  def check_character_types
    CheckCharacterTypes.new(string)
  end

  def word_score
    CheckCharacterTypes.word_score
  end
end