class Pawn < Piece
  def initialize(board,pos)
    @start_pos = pos
    @board = board
    @pos = pos
  end

  def move_dirs
  end
end
