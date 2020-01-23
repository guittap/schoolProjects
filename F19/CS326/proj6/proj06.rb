############################

#      Wargen Guittap      #
#     CS 326 Project 6     #

############################

def wordScore (word)
    $i = 0
    $sum = 0
    $mul = 1

    # this if statement checks for if the first digit is a number
    if word.slice(0).match(/[[:digit:]]/)
        $mul = word.slice(0).to_i
        if $mul != 2 && $mul != 3
            print "Error found bad multiplier after.\n\n"
            return -1
        end
        $i += 1
        if word.length == 1
            print "nice try! that wont work buddy.\n\n"
            return -3
        end
    end

    # this if statement will go through every character and add it to a running rum
    while $i < word.length
        if word.slice($i).match(/^[[:alpha:]]$/)
            $letterScore = letterScore(word.slice($i))
            if $i + 1 < word.length && word.slice($i+1).match(/[[:digit:]]/)
                $letMul = word.slice($i+1).to_i
                if $letMul != 2 && $letMul != 3
                    print "Error found bad multiplier after.\n\n"
                    return -1
                end
                $letterScore *= $letMul
                $i += 1
            end
            $sum += $letterScore
        elsif word.slice($i).match(/[[:digit:]]/)
            print "Error found bad multiplier after.\n\n"
            return -1
        else
            print "Error found bad character '#{word.slice($i)}'.\n\n"
            return -2
        end
        $i += 1
    end

    return $sum * $mul
end

def letterScore (letter)
    letter = letter.capitalize

    #hash table which holds all the letters and thier scores
    scrabbleLetters = {
        "A" => 1, "B" => 3, "C" => 3, "D" => 2, "E" => 1,
        "F" => 4, "G" => 2, "H" => 4, "I" => 1, "J" => 8, 
        "K" => 5, "L" => 1, "M" => 3, "N" => 1, "O" => 1, 
        "P" => 3, "Q" => 10, "R" => 1, "S" => 1, "T" => 1,
        "U" => 1, "V" => 4, "W" => 4, "X" => 8, "Y" => 4,
        "Z" => 10
    }
    return scrabbleLetters[letter]
end

puts "\nScrabble Score Calculator\n\n"

print "Enter word to score: " 
word = gets
while word.slice(0) != ("\n")
    $score = wordScore(word.delete("\n"))
    if $score >= 0
        puts "Score for '#{word.delete("\n")}' is: #$score\n\n"
    end

    print "Enter word to score: " 
    word = gets
end

puts "\nBye!\n\n"