#Wargen Guittap // CS 326
require "csv"

#variables
data = CSV.read(ARGV[1])
projTitle = data[0][1]
asNum = data[1][2]
testNum = data[2][2]
asWeight = data[3][2]
testWeight = data[4][2]
possible = data[6][2..data[6].size]
scores = data[7..data.size]
scores = scores.sort

#the possble calculations use later for finding estimated grade
$asPossible = 0 
$testPossible = 0
$i = 0
while $i < asNum.to_i
    $asPossible += possible[$i].to_i
    $i += 1
end
while $i < scores[$i].size
    $testPossible += possible[$i].to_i
    $i += 1
end

#initializing html document
puts "<!DOCTYPE html>"
puts "<html lang='en'>"
puts "<head>"
puts "    <meta charset='UTF-8'>"
puts "    <meta name='viewport' content='width=device-width, initial-scale=1.0'>"
puts "    <meta http-equiv='X-UA-Compatible' content='ie=edge'>"
puts "    <title>" + projTitle + "</title>"
puts "    <style>"
puts "        table, th, td {"
puts "            border: 1px solid black;"
puts "            text-align: center;"
puts "        }"
puts "    </style>"
puts "</head>"
puts "<body>"

puts "    <h1>" + projTitle + "</h1>"
puts "    <h2>As of: " + Time.now.strftime("%A, %B %d, %Y") + "</h2>"

#for headers
puts "    <table style='width:50%'>"
puts "        <tr>"
$i = 0
while $i < data[7].size    #this simply goes through the data array and outputs the headers
    if ARGV[0] == '-ids' && $i == 1 
        $i += 1
    end
    puts "            <th>" + data[5][$i] + "</th>"
    $i += 1
end
puts "            <th>Est Score</th>"
puts "        </tr>"

#for scores
$i = 0
while $i < scores.size #loops though each id
    puts "        <tr>"
    $j = 0
    while $j < scores[$i].size #this will print out all the scores
        if ARGV[0] == '-ids' && $j == 1 #if -ids is given, then we will remove names
            $j += 1
        end
        puts "            <td>" + scores[$i][$j].to_s + "</td>"
        $j += 1
    end

    #this will calculate the estimated score of the student
    $k = 2
    $est = 0
    $asEst = 0
    $testEst = 0
    while $k < asNum.to_i + 2   #because of id and name, we add 2 to the iterator
        $asEst += scores[$i][$k].to_f
        $k += 1
    end
    $est += ($asEst.to_f / $asPossible.to_f) * (asWeight.to_f * 0.01) #calculation for assignments

    while $k < scores[$i].size
        $testEst += scores[$i][$k].to_f
        $k += 1
    end
    $est += ($testEst.to_f / $testPossible.to_f) * (testWeight.to_f * 0.01) #calculation for tests
    $est *= 100
    puts "            <td>#{$est.round(2)}</td>"
    puts "        </tr>"
    $i += 1
end

#for average
puts "        <tr>"
puts "            <th>Average</th>"
if ARGV[0] == '-names'
    puts "            <th></th>"
end
$i = 2
while $i < scores[$i].size
    $trueSize = scores.size
    $sum = 0
    $j = 0
    while $j < scores.size
        if scores[$j][$i].to_i == 0 #this is for finding true size when the score is = 0 
            $trueSize -= 1          #this will only work if a student getting a complete 0 does not count towards average
        end
        $sum += scores[$j][$i].to_i
        $j += 1
    end
    $avg = $sum.to_f / $trueSize #this will calculate the average of the class
    puts "            <th>#{$avg.round(1)}</th>"
    $i += 1
end
puts "            <th></th>"
puts "        </tr>"

#for possible
puts "        <tr>"
puts "            <th>Possible</th>"
if ARGV[0] == '-names'
    puts "            <th></th>"
end
$i = 0
while $i < possible.size #this will simply iterate through the possible size array and output the numbers
    puts "            <th>" + possible[$i] + "</th>"
    $i += 1
end
puts "            <th></th>"
puts "        </tr>"
puts "    </table>"

#footer items
puts "<h3>Grading Formula:</h3>"
puts "<h4>Grading Formula: [((homework scores/possible) * #{asWeight.to_f*0.01})+((test scores/possible) * #{testWeight.to_f*0.01})]</h4>"
puts "</body>"
puts "</html>"