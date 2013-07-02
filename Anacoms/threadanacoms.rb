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
      # processing of each word can be done in parallel - could earn a few nanoseconds in jruby. Does introduce race condition on longest & most frequent anagrams.
      threads = []
      threads << Thread.new(word, key) do |lword, lkey|
        (anacoms[lkey] ||= []) << lword
        if anacoms[lkey].length > 1
          # update longest anagram
          longest << lkey if lword.length == lenlongest && !longest.include?(lkey) 
          longest, lenlongest = [lkey], lword.length if lword.length > lenlongest
          # update most frequent anagram combo
          most << lkey if anacoms[lkey].length == lenmost && !most.include?(lkey)
          most, lenmost = [lkey], anacoms[lkey].length if anacoms[lkey].length > lenmost
        end
      end
      threads.each {|thr| thr.join }
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
