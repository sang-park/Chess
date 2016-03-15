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
    @current_player = :white
    @next_player = :black
  end

  def swap_players!
    @current_player, @next_player = @next_player, @current_player
  end

  def play
    until board.checkmate?(@current_player)
      play_turn
      swap_players!
    end
    puts "Checkmate. #{@next_player} wins!"
  end

  def get_move
    result = nil
    until result
      @display.render
      p @display.cursor_pos
      unless @first_move.nil?
        p "Move #{board[@first_move].class} from: #{@first_move}"
      end
      result = @display.get_input
    end
    result
  end


  def play_turn
    if @board.in_check?(@current_player)  #REVISE
      puts "Check"
      sleep 1
    end
    @first_move = nil   #reset first move
    @first_move = get_move
    first_piece = @board[@first_move]
    if first_piece.empty?
      raise ChessError.new("There is no piece at this position")
    elsif first_piece.color == @next_player
      raise ChessError.new("Not your piece. Your color is #{@current_player}")
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
