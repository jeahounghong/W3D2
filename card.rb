class Card
    attr_reader :reveal, :face_value

    def initialize(face_value)
        @face_value = face_value
        @reveal = false;
    end

    # def reveal
    #     @face_value
    # end


end