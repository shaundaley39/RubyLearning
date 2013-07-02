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
    infile = File.new(infilename, "r")
    while (line = infile.gets)
      word = line.strip
      key = word.downcase.chars.sort
      (anacoms[key] ||= []) << word
      if anacoms[key].length > 1
        # update longest anagram
        case 
          when word.length == lenlongest
            longest << key unless longest.include?(key)
          when word.length > lenlongest
            longest = [key]
            lenlongest = word.length
        end
        # update most frequent anagram combo
        case
          when anacoms[key].length == lenmost
            most << key unless most.include?(key)
          when anacoms[key].length > lenmost
            most = [key]
            lenmost = anacoms[key].length
        end
      end
    end
  rescue => err
    puts "Exception reading file: #{err}"
    raise
  end
  # writing output
  begin
    outfile = File.new("anacoms_of_"+infilename, "w")
    anacoms.each do |key, value|
      if value.length > 1
        value.each do |ow| 
          outfile << ow  << " "
        end
        outfile << "\n"
      end
    end
  rescue => err
    puts "Exception writing file: #{err}"
    raise
  ensure
    outfile.close unless outfile.nil?
  end
  # printing freaks of the language
  print "The length of the longest anagram is " + lenlongest.to_s + ":\n"
  longest.each do |key| 
    print "{" 
    print (anacoms[key].join(", "))
    print "}\n" 
  end
  print "\nThe most frequent anagram has "+ lenmost.to_s + " words:\n"
  most.each do |key| 
    print "{" 
    print (anacoms[key].join(", ")) 
    print "}\n" 
  end
  nil
end
