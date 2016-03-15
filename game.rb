require_relative 'pieces.rb'
require_relative 'board.rb'
require_relative 'cursorable.rb'
require_relative 'display.rb'
require 'byebug'

class ChessError < StandardError
end

class Game
  attr_reader :board
  def initialize
    @board = Board.new
    @board.setup
    @display = Display.new(@board)
    @first_move = nil
    @second_move = nil
  end

  def play
    5.times {play_turn}   #REMOVE
  end

  def get_move
    result = nil
    until result
      @display.render
      # if @display.cursor_pos == [3,0]
      #   debugger
      # end
      p @display.cursor_pos
      unless @first_move.nil?
        p "Move #{board[@first_move].class} from: #{@first_move}"
      end
      result = @display.get_input
    end
    result
  end

  def play_turn
    @first_move = nil   #reset first move
    @first_move = get_move
    if @board[@first_move].empty?
      raise ChessError.new("There is no piece at this position")
    end
    @second_move = get_move
    @board.move(@first_move,@second_move)
  rescue ChessError => e
    puts e.message
    sleep 1  #pause before clearing
    retry
  end
end

g = Game.new
g.play
