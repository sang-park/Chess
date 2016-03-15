require_relative 'pieces.rb'
require_relative 'board.rb'
require_relative 'cursorable.rb'
require_relative 'display.rb'

class Game
  def initialize
    @board = Board.new
    @board.setup
    @display = Display.new(@board)
  end

  def play
    5.times {play_turn}   #REMOVE
  end

  def play_turn
    result = nil
    until result
      @display.render
      result = @display.get_input
    end
    result
  end
end

g = Game.new
g.play
