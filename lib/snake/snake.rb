module Snake
  class Snake
    attr_reader :size, :board_xy
    attr_accessor :move_direction, :alive

    def initialize(board=nil, start_size=3)
      @alive = true
      @body_parts = []
      @board = board || nil
      @flies = board.flies_list || []
      @board_xy = board ? board.get_size : [30, 100]
      @size = start_size
      @move_direction = :left
      init_body
      slide(@move_direction)
    end

    def slide(direction=@move_direction)
      # protection against the backwards moves
      dir_check = [direction, @move_direction]
      if ((dir_check.include? :left) && (dir_check.include? :right)) || ((dir_check.include? :up) && (dir_check.include? :down))
        move = DIRECTIONS.fetch(@move_direction)
      else
        move = DIRECTIONS.fetch(direction)
        @move_direction = direction
      end

      return death unless valid_move?(move)
      #snake grows if cell actual cell contains fly
      points = eat_fly(move)
      grow(move) if points != 0
      @body_parts.each { |part| move = part.make_move(*move) }
      #if move is correct method returns validation of 'alive' state and  number of gained points
      [true, points]
    end

    def get_body_positions
      @body_parts.each { |part| part.get_xy }
    end

    private

    def init_body
      size = @size - 1
      board_x, board_y = *@board_xy
      @body_parts << Head.new(board_x, board_y)
      size.times do
        @body_parts << Body.new(board_x, (board_y+=2))
      end
    end

    def grow(direction_xy)
      @body_parts << @body_parts.last.dup
    end

    def eat_fly(xy)
      points = 0
      xy = [@body_parts.first.get_xy, xy].transpose.map { |e| e.reduce(&:+) }
      @board.flies_list.each { |fly| points += fly.points if fly.get_xy == xy }
      @board.flies_list.reject! { |fly| fly.get_xy == xy }
      points
    end

    def death
      [false, 0]
    end

    def rest
      [true, 0]
    end

    def valid_move?(move)
      next_move = []
      @body_parts.each_with_index do |part, i|
        if i == 0
          next_move = [part.get_xy, move].transpose.map { |e| e.reduce(&:+) }
        else
          return false if part.get_xy == next_move
        end
      end
      true
    end

  end
end
