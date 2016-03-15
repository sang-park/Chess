class Rook < Piece
  include Sliding
  attr_reader :pos

  def move_dirs
    direction = Sliding::LINEAR
    moves(direction)
  end

  def to_s
    if @color == :white
      " ♖ "
    else
      " ♜ "
    end
  end
end
