class Card
    attr_reader :face_value
    attr_accessor :reveal

    def initialize(face_value)
        @face_value = face_value
        @reveal = false
    end

    # def reveal
    #     @face_value
    # end


end