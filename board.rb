
class Board
  include Enumerable

  def initialize
    @grid = Array.new(8) {Array.new(8)}
    @grid.each_with_index do |row,i|
      row.each_index do |j|
        @grid[i][j] = EmptyPiece.new(self, [i,j],nil)
      end
    end
  end

  def each(&blk)
    @grid.each(&blk)
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos,val)
    x, y = pos
    @grid[x][y] = val
  end

  def setup
    back_pieces = [
      Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook
    ]

    [[0,:black],[7,:white]].each do |i, color|
      back_pieces.each_with_index do |piece_class, j|
        self[[i, j]] = piece_class.new(self, [i,j], color)
      end
    end

    #setup pawns
    [[1,:black],[6,:white]].each do |i,color|
      (0..7).to_a.each do |j|
        self[[i,j]] = Pawn.new(self, [i,j], color)
      end
    end
  end

  def move(start_pos,end_pos)
    valid_moves = self[start_pos].valid_moves

    expose_king?(start_pos,end_pos)
    valid_end_position?(end_pos,valid_moves)

    piece = self[start_pos]
    piece.pos = end_pos
    pawn_reached_end?(end_pos)
    self[start_pos] = EmptyPiece.new(self,start_pos,nil)
  end

  def in_bounds?(pos)
    pos.all? {|el| el.between?(0,7)}
  end

  def in_check?(color)
    king_pos = find_king(color).pos

    opponent_pieces = @grid.flatten.select do |piece|
      !piece.empty? && piece.color != color
    end

    opponent_pieces.any? do |piece|
      piece.move_dirs.include?(king_pos)
    end
  end

  def checkmate?(color)
    return false unless in_check?(color)

    current_player_pieces = @grid.flatten.select do |piece|
      !piece.empty? && piece.color == color
    end

    current_player_pieces.all? do |piece|
      piece.valid_moves.empty?
    end
  end

  def dup
    new_board = Board.new
    pieces = @grid.flatten
    pieces.each do |piece|
      dup_piece = piece.class.new(new_board,piece.pos,piece.color)
      new_board[piece.pos] = dup_piece
    end
    new_board
  end

  def move!(start_pos,end_pos) #used for duped board
    piece = self[start_pos]
    piece.pos = end_pos
    self[start_pos] = EmptyPiece.new(self,start_pos,nil)
  end

  private

  def find_king(color)
    @grid.flatten.each do |piece|
      return piece if piece.is_a?(King) && piece.color == color
    end
    raise ChessError.new("No #{color} King found!")
  end

  def pawn_reached_end?(pos)
    if self[pos].is_a?(Pawn) && (pos[0] == 0 || pos[0] == 7)
      self[pos] = Queen.new(self,pos,self[pos].color)
    end
  end

  def expose_king?(start_pos,end_pos)
    if self[start_pos].move_to_check?(end_pos)
      raise ChessError.new("Your king is exposed")
    end
  end

  def valid_end_position?(end_pos, valid_moves)
    unless valid_moves.include?(end_pos)
      raise ChessError.new("cannot move to that position")
    end
  end

end
