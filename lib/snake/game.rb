module Snake
  class Game
    attr_reader :scoreboard

    def initialize(board=nil, snake=nil)
      @scoreboard = []
      set_player
      @board = board || Board.new
      @snake = snake || Snake.new(@board, 3)
    end

    def play
      init_screen
      curs_set(0)
      noecho
      @board.print_board
      until game_over?
        @board.born_flies(@snake.get_body_positions)
        @board.print_flies
        @board.show_score(@player.points)
        move
      end
      print_score
      save_result
    end

    private

    def move
      crmode
      @snake.alive, points = case getch
        when "w" then @snake.slide(:up)
        when "s" then @snake.slide(:down)
        when "a" then @snake.slide(:left)
        when "d" then @snake.slide(:right)
        when "q" then @snake.death
        else @snake.rest
      end
      @player.points += points
    end

    def save_result
      Dir.mkdir('../save') unless File.exists?('../save')
      save = YAML::Store.new "../save/results.yaml"
      save.transaction do
        save["results"] ||= []
        save["results"] << @player
      end
    end

    def load_results
      return @scoreboard = [] unless File.exists?('../save')
      save = YAML.load(File.new("../save/results.yaml"))
      @scoreboard = save["results"]
    end

    def print_scoreboard
      @scoreboard.sort! {|x,y| y.points <=> x.points }
      puts "BEST PLAYERS:\n"
      @scoreboard.each_with_index do |player, i|
          puts "#{i+1}. #{player.points} pts - #{player.name}"
          break if i == 4
      end
      puts "\n"
    end

    def greeting
      puts "Hello #{@player.name}! Let's play the game."
      sleep 2
    end

    def set_player
      load_results
      print_scoreboard
      puts "Hi stranger, what's your name?"
      name = gets.chomp!
      @player = Player.new(name)
      greeting
    end

    def game_over?
      !@snake.alive
    end

    def print_score
      clear
      refresh
      puts "Game over. Your score is: #{@player.points}."
      getch
      close_screen
    end
  end

end
