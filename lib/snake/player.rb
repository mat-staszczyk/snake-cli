module Snake
  class Player
    attr_reader :name
    attr_accessor :points

    def initialize(name="Player")
      @name = name
      @points = 0
    end
  end
end
