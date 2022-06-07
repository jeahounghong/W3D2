# class Game

# end
require_relative 'board.rb'
require_relative 'card.rb' 
puts "Enter a size for the game:"
n = gets.chomp.to_i
b = Board.new(n)

until b.win? do
    puts "-----------------"
    b.turn
end
