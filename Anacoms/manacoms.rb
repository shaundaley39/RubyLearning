#!/usr/bin/env ruby
# reads file infilename, a list of words with one word on each line. Prints longest anagram & most frequent anagram. Writes all sets of anagram words to anacoms_of_infilename
def anacoms(infilename)
  # hash used for testing whether words are anagrams of one another
  anacoms={}
  # longest anagram yet found
  lenlongest = 0
  longest = []
  # biggest anagram word set found so far
  lenmost = 0
  most=[]
  # reading & populating
  begin
    File.open(infilename).each_line do |line|
      word = line.strip
      key = word.downcase.chars.sort
      (anacoms[key] ||= []) << word
      if anacoms[key].length > 1
        # update longest anagram
        longest << key if word.length == lenlongest && !longest.include?(key) 
        longest, lenlongest = [key], word.length if word.length > lenlongest
        # update most frequent anagram combo
        most << key if anacoms[key].length == lenmost && !most.include?(key)
        most, lenmost = [key], anacoms[key].length if anacoms[key].length > lenmost
      end
    end
  rescue => err; puts "Exception reading file: #{err}"; raise
  end
  # writing output
  begin
    outfile = File.new("anacoms_of_"+infilename, "w")
    anacoms.each { |key, value| if value.length > 1 then value.each { |ow| outfile << ow  << " "}; outfile << "\n" end }
  rescue => err; puts "Exception writing file: #{err}"; raise
  ensure outfile.close unless outfile.nil?
  end
  # printing freaks of language
  print "The length of the longest anagram is #{ lenlongest.to_s}:\n"; longest.each { |key| print "{#{(anacoms[key].join(", "))}}\n"}
  print "The most frequent anagram has #{lenmost.to_s} words:\n"; most.each { |key| print "{#{(anacoms[key].join(", "))}}\n"}
  nil
end
