
class Tile

    attr_reader :value, :shown

    def initialize(value, shown)
        @value = value
        @shown = shown == 0 ? false : true
    end

    def to_s
        return @shown ? @value.to_s : "_"
    end

    def show
        @shown = true
    end

end