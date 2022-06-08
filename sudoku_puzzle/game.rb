
require_relative 'board.rb'
require_relative 'tile.rb'
require_relative 'computer_player_v2.rb'

class Game

    def initialize

        @board = Board.new('puzzles/sudoku1.txt', 'puzzles/sudoku1_solved.txt')
        @player = ComputerPlayer.new("David's Bot")
        @incorrect_guesses = 0

    end

    def run
        while !self.game_over? do 
            system("clear")
            @board.display_grid
            @player.read_grid(@board.shown_grid)
            p @board.shown_grid
            puts
            puts "Incorrect Guesses: #{@incorrect_guesses}"
            puts "Please provide a guess of the form 1,2,3"
            puts "where 1 is the row, 2 is the col, 3 is the guess"
            answer = @player.get_move
            p "#{@player.name} tried: #{answer}"
            @board.try(answer)
            # sleep(0.05)
            @incorrect_guesses += 1
        end
        puts
        puts "Incorrect Guesses: #{@incorrect_guesses}"
        puts
        return @incorrect_guesses
    end

    def game_over?
        @board.game_over?
    end


end

arr = []
100.times do
    game = Game.new
    arr << game.run
end
p arr
puts arr.sum/(arr.size*1.0)