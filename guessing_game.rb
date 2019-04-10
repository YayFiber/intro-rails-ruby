number = rand(10) + 1

puts "Welcome to my guessing game!"
puts "-" * 20

won = false

5.times do
  print "Guess my number (1-10) " # print does not return a new line after the text, puts does
  guess = gets.to_i #gets grabs a string by default --- to_i solves (integer)
  if guess == number
    won = true
    break
  end
end

if won
  puts "You win."
else 
  puts "Incorrect, try again" # + "The correct number was #{number}" #+ number.to_s -- or STRING INTERPOLATION --- this format: #{}
# # else guess < number
# #   puts "Too low."
end