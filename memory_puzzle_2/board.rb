require_relative 'card.rb'
require_relative 'computer_player.rb'

class Board
    attr_reader :arr, :grid
    def initialize(num)
        @num = num * 2
        @size = @num * @num
        @grid = Array.new(@num) {Array.new(@num)}
        @arr = []
        @alphabet = ("A".."Z").to_a
        @player = ComputerPlayer.new("Andy")

        (0...@size/2).each do |i|
            2.times do
                @arr << @alphabet[i]
            end
        end
        @arr = @arr.shuffle
        self.fill_grid
        self.display_grid

    end

    def [](pos)
        @grid[pos[0]][pos[1]]
    end

    def []=(pos, value)
        @grid[pos[0]][pos[1]] = value
    end

    def fill_grid
        @grid.each_with_index do |row,i|
            row.each_with_index do |ele,j| 
                # @grid[i][j] = Card.new(arr[j + @num*j]) 
                @grid[i][j] = Card.new(arr[j + @num*i])
            end
        end
    end

    def grid_for_player
        array = []
        @grid.each_with_index do |el,i|
            arr = []
            el.each_with_index do |ele,j|
                if ele.reveal
                    arr << ele.face_value
                else
                    arr << nil
                end
            end
            array << arr
        end
        array
    end

    def display_grid
        @grid.each_with_index do |row,i|
            temp_array = []
            row.each_with_index do |ele,j| 
                # @grid[i][j] = Card.new(arr[j + @num*j]) 
                if @grid[i][j].reveal
                    temp_array << @grid[i][j].face_value
                else
                    temp_array <<  "_"
                end
            end
            puts temp_array.join(" ")
        end
        puts
    end

    def pair?(pair_1, pair_2)

        return self[pair_1].face_value == self[pair_2].face_value
    end

    # def get_move(pos)
        
        
    #     if self.pair?(pos, pos2)
    #         self[pos].reveal = true
    #         self[pos].reveal = true
    #     end
    #     self.display_grid
    # end

    def turn
        system("clear")
        self.display_grid

        p 'Please enter a position'
        # pos = gets.chomp
        pos = @player.get_move(self.grid_for_player)
        pair_1 = pos.split(",")
        pair_1.map! {|ele| ele.to_i}
        self[pair_1].reveal = true
        system("clear")
        self.display_grid
        sleep(0.01)
        p 'Please enter another position'
        # pos2 = gets.chomp
        pos2 = @player.get_move(self.grid_for_player)
        pair_2 = pos2.split(",")
        pair_2.map! {|ele| ele.to_i}
        self[pair_2].reveal = true
        self.display_grid
        @player.read_grid(self.grid_for_player)
        if !self.pair?(pair_1, pair_2)
            self[pair_2].reveal = false
            self[pair_1].reveal = false
        end

        sleep(0.01)
        system("clear")
    end

    def win?
        @grid.each do |row|
            return false if row.any? {|el| el.reveal == false}
        end
        puts "You win!"
        self.display_grid
        #puts @player.known
        true
    end
end

# a = [1,2,3,4,5,6,7]
# 7.times do
#     puts a.sample
# end


