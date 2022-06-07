

class ComputerPlayer

    attr_reader :known
    def initialize(name)
        @name = name
        @known = Hash.new {|h,k| h[k] = []}
        @next_move_available = []

    end

    def get_move(arg)
        poss_moves = self.possible_moves(arg)
        answer = nil
        self.read_grid(arg)
        if @next_move_available.length > 0 && poss_moves.include?(@next_move_available[0])
            answer = @next_move_available.shift
            return answer.join(",")
        else
            @known.each_value do |v|
                if v.length == 2 && (poss_moves.include?(v[0]) && poss_moves.include?(v[1]))
                    @next_move_available << v[0]
                    @next_move_available << v[1]
                    #answer = @next_move_available.shift
                end
            end
        end

        answer = poss_moves.sample if answer == nil
        return answer.join(",")
        

        # RETURNING A STRING IN THE FORM "0,0"
    end

    def possible_moves(array)
        pm = []
        array.each_with_index do |row,i|
            row.each_with_index do |el,j|
                if el == nil
                    pm << [i,j]
                end
            end
        end
        pm
    end

    def read_grid(arg)
        arg.each_with_index do |row, i|
            row.each_with_index do |el, j|
                if !(@known[el].include?([i,j])) && el != nil
                    @known[el] << [i,j]
                end
            end 
        end
    end
end