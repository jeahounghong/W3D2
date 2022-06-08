require_relative 'tile.rb'
require_relative 'computer_player.rb'
require 'csv'

class Board

    attr_reader :grid, :shown_grid

    def [](pos)
        @grid[pos[0]][pos[1]]
    end

    def []=(pos,val)
        @grid[pos[0]][po[1]] = value
    end

    def shown_grid
        arr = []
        @grid.each do |row|
            temp_array = []
            row.each do |ele|
                if ele.shown
                    temp_array << ele.value
                else
                    temp_array << 0
                end
            end
            arr << temp_array
        end
        arr
    end

    def initialize(source, solved_source)
        @grid = CSV.read(solved_source)
        @grid = @grid.map {|el| el[0].split("")}
        @grid = @grid.map {|el| el.map {|ele| ele.to_i}}
        #p @grid
        @shown_grid = CSV.read(source)
        @shown_grid = @shown_grid.map {|el| el[0].split("")}
        @grid.each_with_index do |el,i|
            el.each_with_index do |ele,j|
                #p @shown_grid[i][j]
                @grid[i][j] = Tile.new(ele, @shown_grid[i][j].to_i)
                #p @grid[i][j]
            end
        end

        
    end

    def display_grid
        puts
        @grid.each_with_index do |row,i|
            arr =  row.join(" ")
            print "#{arr[0..4]} | #{arr[6..10]} | #{arr[12..16]} "
            puts
            if i == 2 || i == 5
                print "---------------------"
                puts
            end
        end
        puts
    end

    def try(attempt) 
        # attempt is a array of form [1,2,3]
        # where 1 is the r
        # 3 is the c
        # and 3 is the attempted value
        if attempt.length != 3
            p "wrong format"
            return false
        end
        if !(0..8).to_a.include?(attempt[0]) || !(0..8).to_a.include?(attempt[1])
            p "Out of bounds"
            return false
        end
        if self[attempt].shown
            p "Number is already shown"
            return false
        end
        if self[attempt].value == attempt[2]
            self[attempt].show
        end
    end

    def game_over?
        @grid.each do |row|
            row.each do |ele|
                return false if !ele.shown
            end
        end
        system("clear")
        self.display_grid
        p "WON!"
        true
    end

end

b = Board.new('puzzles/sudoku1.txt', 'puzzles/sudoku1_solved.txt')
b.display_grid