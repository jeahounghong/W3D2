
class ComputerPlayer

    attr_reader :possible_moves, :name

    def initialize(name)
        @name = name
        @grid = nil
        @possible_moves = Hash.new {|h,k| h[k] = []}
        (0..8).each do |i|
            (0..8).each do |j|
                (1..9).each do |k|
                    @possible_moves[[i,j]] += [ k ]
                    #p @possible_moves[[i,j]]
                end
            end
        end
        #p @possible_moves
    end

    def read_grid(grid)
        @grid = grid
    end

    def find_possible_moves
        @grid.each_with_index do |row, i|
            row.each_with_index do |ele,j|
                if @grid[i][j] != 0
                    @possible_moves.delete([i,j])
                end
            end
        end
        @possible_moves.each do |k,v|
            i = k[0]

            # CHECKS THE HORIZONTAL ROW
            (1..9).each do |el|
                @possible_moves[k].delete(el) if @grid[i].include?(el)
            end

            j = k[1]
            (1..9).each do |el|
                (0..8).each do |ele|
                    @possible_moves[k].delete(el) if @grid[ele][j] == el
                end
                #@possible_moves[k].delete(el) if @grid[][j].include
            end

        end
        # @possible_moves.each do |k,v|

        # end
    end

    def get_move
        self.find_possible_moves
        #p @possible_moves
        key = @possible_moves.keys.sample
        #p key
        value = @possible_moves[key].sample
        return key += [value]
    end
end

# cp = ComputerPlayer.new("name")
# p cp.possible_moves