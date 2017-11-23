#!/usr/bin/env ruby

# 1. Create a wordlist that would match/describe the images
# 2. Eliminate words in wordlist that are not length of $word_length
# 3. Get permutations of 4 letters that can be made out of $letters
# 4. Test if permutations contains any element from (filtered) wordlist or dictionary if there are no results
# 5. Save results to file

$word_length = 4
$letters = ["e", "k", "i", "l", "w", "c", "o", "r", "h", "z", "m", "g"]

# Wordlist that match the criteria of an image
$wordlist = File.open("./glossary.txt") || []
$temp_perms = []
$filtered = []
$dictionary = []

# Eliminate words that are not length of $word_length
def sort_words()
  $wordlist.each { |word|
    word = word.strip
    $filtered.push(word) if word.length === $word_length
  }
end

sort_words()

# Get permutations of 4 letters that can be made out of $letters
def permutation()
  perms = $letters.permutation($word_length).to_a.map(&:join)
  output = "./permutations.txt"

  # Save results
  File.delete(output) if File.exist?(output)
  File.open(output, "w") { |line|
    perms.each { |perm| line.puts perm; $temp_perms.push(perm.strip) }
  }
end

permutation()

# Test if permutations contains any element from (filtered) wordlist
def matching_words
  output = "./results.txt"

  # If word in permutation is not in (filtered) wordlist check if permutation is in dictionary
  if ($temp_perms & $filtered).empty?
    File.open("./dictionary.txt", "r").each_line { |line|
      $dictionary.push(line.strip) if line.strip.length === $word_length
    }
    $results = $temp_perms & $dictionary
  else
    $results = $temp_perms & $filtered
  end

  # Write results to file
  puts "Results are saved in #{output}"
  File.delete(output) if File.exist?(output)
  File.open(output, "w") { |line|
    line.puts $results
  }
end

matching_words()