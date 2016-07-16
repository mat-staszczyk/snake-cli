module Snake
  class Fly
    attr_reader :x, :y, :board_x, :board_y, :sign, :points

    def initialize(board_size)
      @sign = "*"
      @points = generate_points
      @board_x, @board_y = board_size
      generate_position
    end

    def get_xy
      [@x, @y]
    end

    private

    def generate_points
      generator = SecureRandom.random_number(100)
      if generator >= 90 then 10
      elsif generator >= 70 then 5
      else 1
      end
    end

    def generate_position
      @x = SecureRandom.random_number(@board_x-2)+1
      @y = SecureRandom.random_number(@board_y-2)+1
    end

  end
end
