module Snake
  class Head < Body
    def initialize(x, y)
      super
      @sign = "@"
    end

    def make_move(x, y)
      temp_x, temp_y = @x, @y
      setpos(@x, @y)
      addstr " "
      single_step(x,y)
      setpos(@x, @y)
      addstr @sign
      [temp_x, temp_y]
    end

    private

    def single_step(x, y)
      if @x + x <= 0
        @x = @board_x-2
      elsif @x + x >= @board_x-1
        @x = 1
      else
        @x += x
      end

      if @y + y <= 0
        @y = @board_y-2
      elsif @y + y >= @board_y-1
        @y = 1
      else
        @y += y
      end
    end

  end
end
