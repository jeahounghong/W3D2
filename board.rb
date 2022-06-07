require_relative 'card.rb'
class Board
    attr_reader :arr, :grid
    def initialize(num)
        @num = num * 2
        @size = @num * @num
        @grid = Array.new(@num) {Array.new(@num)}
        @arr = []
        @alphabet = ("A".."Z").to_a

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

    def display_grid
        @grid.each_with_index do |row,i|
            str = ""
            row.each_with_index do |ele,j| 
                # @grid[i][j] = Card.new(arr[j + @num*j]) 
                if @grid[i][j].reveal
                    str += @grid[i][j].face_value
                else
                    str += "_"
                end
            end
            puts str
        end
    end

    def check_pair(pair_1, pair_2)
        pair_1 = pair_1.split(",")
        pair_2 = pair_2.split(",")
        pair_1.map {|ele| ele.to_i}
        pair_2.map {|ele| ele.to_i}
        return self[pair_1] == self[pair_2]
    end
end

# a = [1,2,3,4,5,6,7]
# 7.times do
#     puts a.sample
# end


b = Board.new(2)
# p b.arr
# p b.grid