def rand_char(len)
  rand(36**len).to_s(36)
end

def check_password_strength(in_string)
  num_char_types = count_character_types(in_string)
  out_pw = check_dictionary(in_string)
  out_length = out_pw.length
  pw_strength = num_char_types * out_length
  message = ''
  if pw_strength >= 50
    message = "Congratulations on your strong password"
  elsif (11..49) === pw_strength
    message =  out_pw << fix_password(num_char_types, out_length)
  elsif pw_strength <= 10
    message = "Your password is not adequate.  Please try again."
  end
  message
end

def fix_password(num_char_types, num_length)
  num_to_replace = ((50/num_char_types) + 1) - num_length
  return rand_char(num_to_replace)
end

def count_character_types(in_string)
  char_types = 0
  if in_string =~ /[[:ascii:]][[:alpha:]]/
    char_types += 1
  end
  if in_string =~ /[[:digit:]]/
    char_types += 1
  end
  if in_string =~ /[[:space:]]/
    char_types += 1
  end
  if in_string =~ /[^[:ascii:]][[:alnum:]]/ ||
      in_string =~ /[[:punct:]]/ ||
      in_string =~ /[_*!@#$%&+=|{}]/
    char_types += 1
  end

  char_types
end

#This is my shortcut hack.  I know that if I were implementing this for real, I would probably connect to a dictionary api
#and check for words that way.  To avoid the "pass", "word" problem, I would have the strings returned in size order
def check_dictionary(in_string)
  new_string = ""
  dictionary = ['password','pass','word','per','goat','cat']
  dictionary.each do |d|
    if (in_string.include? d)
      return in_string.sub(d,rand_char(1))
    end
  end
end

puts check_password_strength("password1")
puts check_password_strength("goat m4n")
puts check_password_strength("s0_0per 5n4k3")