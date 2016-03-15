class Bishop < Piece
  include Sliding
  attr_reader :pos

  def move_dirs
    direction = Sliding::DIAGONAL
    moves(direction)
  end

  def to_s
    " ♗ "
  end
end
