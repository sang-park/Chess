class Piece
  attr_reader :board, :color, :pos


  def initialize(board, pos, color)
    @board = board
    @pos = pos
    @color = color
  end

  def pos=(end_pos)
    @pos = end_pos
    board[end_pos] = self
  end

  def on_board?(pos)
    pos.all? {|el| el.between?(0,7)} #&& board[pos].empty?
  end

  def empty?
    false
  end

  def inspect
    "#{self.class}, #{pos}, #{color}"
  end

end

class EmptyPiece
  attr_reader :pos
  def initialize(board, pos)
    @pos = pos
  end

  def color
    nil
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
