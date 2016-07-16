module Snake
  class Board
    attr_reader :x, :y

    def initialize(x=30, y=100)
      @flies = []
      @x, @y = x, y
    end

    def get_size
      [@x, @y]
    end

    def flies_list
      @flies
    end

    def update_list(new_list)
      @flies = new_list
    end

    def start_point
      [@x/2, @y/2]
    end

    def born_flies(snake_body_pos=[])
      while flies_count < 3 do
        fly = Fly.new(get_size)
        fly.generate_position while (snake_body_pos.include? fly.get_xy) || (@flies.include? fly.get_xy)
        @flies << fly
      end
    end

    def show_score(points)
      setpos(@x+2, 0)
      addstr "Your total score is #{points}."
    end

    def flies_count
      @flies.length
    end

    def print_flies
      @flies.each do |fly|
        setpos(*fly.get_xy)
        addstr(fly.sign)
      end
    end

    def print_board
      for row in 0...@x do
        for col in 0...@y do
          setpos(row, col)
          addstr("#") if (col == 0 || col == @y-1) || (row == 0 || row == @x-1)
        end
      end
      print_instructions
    end

    private

    def print_instructions(points=nil)
      setpos(@x+1, 0)
      addstr("Use W-S-A-D keys to control snake's movement or press Q to quit.")
    end

  end
end
