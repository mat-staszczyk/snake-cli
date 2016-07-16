module Snake
  class Body
    attr_reader :x, :y, :board_x, :board_y, :sign;

    def initialize(x, y)
      @board_x, @board_y = x, y
      @x = x/2
      @y = y/2
      @sign = "o"
    end

    def make_move(x, y)
      temp_x, temp_y = @x, @y
      setpos(@x, @y)
      @x, @y = x, y
      addstr " "
      setpos(x, y)
      addstr @sign
      [temp_x, temp_y]
    end

    def get_xy
      [@x, @y]
    end

  end

end
