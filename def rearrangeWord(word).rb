def rearrangeWord(word)
    a = word.split("")
    permut = a.permutation.to_a
    combi = []
    permut.each do |i|
     combi << i.join("")
    end
    next_com = combi[combi.index(word) + 1]
    if !next_com.nil?
     return word
    else
     return "no answer"
    end
end
