
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

    [[0,:white],[7,:black]].each do |i,color|
      self[[i, 0]] = Rook.new(self, [i, 0],color)
      self[[i, 7]] = Rook.new(self, [i, 7],color)
      self[[i, 1]] = Knight.new(self, [i, 1],color)
      self[[i, 6]] = Knight.new(self, [i, 6],color)
      self[[i, 2]] = Bishop.new(self, [i, 2],color)
      self[[i, 5]] = Bishop.new(self, [i, 5],color)
      self[[i, 3]] = Queen.new(self, [i, 3],color)
      self[[i, 4]] = King.new(self, [i, 4],color)
    end

    [[1,:white],[6,:black]].each do |i,color|
      (0..7).to_a.each do |j|
        self[[i,j]] = Pawn.new(self, [i,j], color)
      end
    end

  end

  def move(start_pos,end_pos)
    valid_moves = self[start_pos].valid_moves
    unless valid_moves.include?(end_pos)
      raise ChessError.new("cannot move to that position")
    end
    piece = self[start_pos]
    piece.pos = end_pos
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
    
    current_pieces = @grid.flatten.select do |piece|
      !piece.empty? && piece.color == color
    end

    current_pieces.all? do |piece|
      piece.valid_moves.empty?
    end
  end

  def find_king(color)
    self.each do |row|
      row.each do |piece|
        if piece.is_a?(King) && piece.color == color
          return piece
        end
      end
    end
    raise ChessError.new("No #{color} King found!")
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

  def move!(start_pos,end_pos)
    piece = self[start_pos]
    piece.pos = end_pos
    self[start_pos] = EmptyPiece.new(self,start_pos,nil)
  end

end
