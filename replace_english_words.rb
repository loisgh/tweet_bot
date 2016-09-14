class ReplaceEnglishWords < Struct.new(:string)

  def munged_string
    @string.map do |char|
      if char  =~ /[[:alpha:]]/
        (a..z).to_a.sample
      else
        char
      end
    end
  end

end