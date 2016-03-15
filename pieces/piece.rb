class Piece
  attr_reader :board, :pos
  def initialize(board, pos)
    @board = board
    @pos = pos
  end

  def valid_moves
  end

  def valid_moves?(pos)
    pos.all? {|el| el.between?(0,7)} && board[pos].empty?
  end

  def empty?
    false
  end

end

class EmptyPiece
  attr_reader :pos
  def initialize(board, pos)
    @pos = pos
  end

  def valid_moves
  end

  def valid_moves?(pos)
  end

  def to_s
    "   "
  end


  def empty?
    true
  end

end
