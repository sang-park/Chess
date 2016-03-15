class Pawn < Piece
  attr_reader :board, :pos, :color
  WHITE = [ 1, 0]
  BLACK = [-1, 0]
  WHITE_ATTACK = [[ 1, -1], [ 1, 1]]
  BLACK_ATTACK = [[-1, -1], [-1, 1]]


  def initialize(board,pos,color)
    @board = board
    @pos = pos
    @color = color
  end

  def move_dirs
    direction = []
    if color == :white
      direction << WHITE
      attack_dirs = WHITE_ATTACK
      if pos[0] == 1 #consider first move if at starting row
        direction << WHITE.map{|el| el*2}
      end
    else
      direction << BLACK
      attack_dirs = BLACK_ATTACK
      if pos[0] == 6
        direction << BLACK.map{|el| el*2}
      end
    end
    moves(direction) + attack_moves(attack_dirs)
    #debugger
  #  raise ChessError.new("#{moves(direction) + attack_moves(attack_dirs)}")
  end

  def moves(direction)
    possible_moves = []
    direction.each do |dx, dy|
      new_pos = [pos[0] + dx, pos[1]+dy]
      possible_moves << new_pos if on_board?(new_pos) && board[new_pos].empty?
    end
    possible_moves
  end

  def attack_moves(direction)
    possible_moves = []
    direction.each do |dx, dy|
      new_pos = [pos[0] + dx, pos[1]+dy]
      new_piece = board[new_pos]
      if on_board?(new_pos) && !new_piece.empty? && new_piece.color != color
        possible_moves << new_pos
      end
    end
    possible_moves
  end

  def on_board?(pos)
    pos.all? {|el| el.between?(0,7)} #&& board[pos].empty?
  end

  def to_s
    if color == :white
      " ♙ "
    else
      " ♟ "
    end
  end
end
