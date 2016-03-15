class Queen < Piece
  include Sliding
  attr_reader :pos

  def move_dirs
    direction = Sliding::DIAGONAL + Sliding::LINEAR
    moves(direction)
  end

  def to_s
    " ♕ "
  end
end
