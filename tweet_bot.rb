def load_dict
  word_array = Array.new
  File.foreach( '/usr/share/dict/words' ) do |line|
    if line.chomp.length > 1
      word_array.push(line.chomp)
    end
  end
  word_array
end

def find_highest_char(in_string)
  highest_char = in_string[0]
  in_string.each_char do |c|
    if (c > highest_char)
      highest_char = c
    end
  end
  if highest_char != 'z'
    highest_char = highest_char.next
  end
  highest_char
end

def find_selected_words(in_string, highest_char, word_array)
  selected_words = Array.new
  word_array.each do |w|
    if highest_char != 'z' && w > highest_char #Get out of loop if we've found the last possible word.
      break
    end
    if (in_string.include? w)
      selected_words.push(w)
    end
  end
  selected_words
end

def rand_char(len)
  rand(36**len).to_s(36)
end

def check_password_strength(in_string, word_array)
  num_char_types = count_character_types(in_string)
  out_pw = check_dictionary(in_string, word_array)
  out_length = out_pw.length
  pw_strength = num_char_types * out_length
  message = ''
  if pw_strength >= 50
    message = "Congratulations on your strong password: #{out_pw}"
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

def check_dictionary(in_string, word_array)
  highest_char = find_highest_char(in_string)
  selected_words = find_selected_words(in_string, highest_char, word_array)
  selected_words.sort_by(&:length).reverse.each do |s|
    if (in_string.include? s)
      in_string = in_string.sub(s,rand_char(1))
    end
  end
  in_string
end

word_array = load_dict        #only load this once
puts check_password_strength("password1", word_array)
puts check_password_strength("goat m4n", word_array)
puts check_password_strength("s0_0per 5n4k3", word_array)
puts check_password_strength("hello1 #$% 1234234world", word_array)