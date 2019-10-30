require "csv"

data = CSV.read(ARGV[1])
projTitle = data[0][1]
asNum = data[1][1]
testNum = data[2][1]
asWeight = data[3][1]
testWeight = data[4][1]
possible = data[6][2..data[6].size]
scores = data[7..data.size]
scores.sort

puts "<!DOCTYPE html>"
puts "<html lang='en'>"
puts "<head>"
puts "    <meta charset='UTF-8'>"
puts "    <meta name='viewport' content='width=device-width, initial-scale=1.0'>"
puts "    <meta http-equiv='X-UA-Compatible' content='ie=edge'>"
puts "    <title>" + projTitle + "</title>"
puts "</head>"
puts "<body>"

puts "    <h1>" + projTitle + "</h1>"
puts "    <h2>As of: " + Time.now.strftime("%A, %B %d, %Y") + "</h2>"

puts "    <table style='width:100%'>"
puts "        <tr>"
$i = 0
while $i < data[7].size 
    puts "            <th>"
    puts "            </th>"
end
puts "        </tr>"
puts "    </table>"

puts "</body>"
puts "</html>"
