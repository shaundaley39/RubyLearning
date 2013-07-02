def compare (*files)
  files = ["anacoms.rb","manacoms.rb","threadanacoms.rb"] if files.length ==0
  totaltimes = {}
  for file in files
    load file
    totaltimes[file] = 0.0
    20.times do
      t1=Time.new
      anacoms("dictionary2.txt")
      t2=Time.new
      totaltimes[file] += t2-t1
    end
  end
  for file in files
    print "Impementation #{file} completed in #{(totaltimes[file]/20).to_s} seconds. \n"
  end
end
