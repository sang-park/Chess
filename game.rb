require_relative 'pieces.rb'
require_relative 'board.rb'
require_relative 'cursorable.rb'
require_relative 'display.rb'
require 'byebug'

class Game
  attr_reader :board
  def initialize
    @board = Board.new
    @board.setup
    @display = Display.new(@board)
  end

  def play
    5.times {play_turn}   #REMOVE
  end

  def get_move
    result = nil
    until result
      @display.render
      #debugger
      p "get_move"
      result = @display.get_input
    end
    p result
    result
  end

  def play_turn
    first_move = get_move
    second_move = get_move
    @board.move(first_move,second_move)
  end


end

g = Game.new
g.board[[5,2]].move_dirs
g.play
