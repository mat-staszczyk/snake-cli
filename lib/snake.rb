require "curses"
require "securerandom"
require "yaml/store"
require_relative "./snake/version.rb"
require_relative "./snake/directions.rb"
include Curses
include Directions

module Snake
end

require_relative "./snake/board.rb"
require_relative "./snake/body.rb"
require_relative "./snake/fly.rb"
require_relative "./snake/game.rb"
require_relative "./snake/head.rb"
require_relative "./snake/player.rb"
require_relative "./snake/snake.rb"
