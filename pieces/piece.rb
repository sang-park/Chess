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
    pos.all? {|el| el.between?(0,7)}
  end

  def valid_moves
    if board.in_check?(color)
      move_dirs.reject do |end_move|
        move_to_check?(end_move)
      end
    else
      move_dirs
    end
  end

  def move_to_check?(end_move)
    dup_board = board.dup
    dup_board.move!(pos,end_move)
    dup_board.in_check?(color)
  end

  def empty?
    false
  end
end

class EmptyPiece
  attr_reader :pos
  def initialize(board, pos, color)
    @board = board
    @pos = pos
  end

  def pos=(end_pos)
    @pos = end_pos
    @board[end_pos] = self
  end

  def color
    nil
  end

  def valid_moves
    #duck typing
  end

  def valid_moves?(pos)
    #duck typing
  end

  def to_s
    "   "
  end

  def empty?
    true
  end
end
