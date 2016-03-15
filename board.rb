
class Board

  include Enumerable

  def initialize()
    @grid = Array.new(8) {Array.new(8)}
    @grid.each_with_index do |row,i|
      row.each_index do |j|
        @grid[i][j] = EmptyPiece.new(self, [i,j])
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

    self[[5,2]] = Pawn.new(self, [5,2],:white)

  end

  def move(start_pos,end_pos)
    raise "no piece at start position" if self[start_pos].empty?
    raise "cannot move to that position" unless self[end_pos].empty?
  rescue => e
    puts "#{e.message}. Try again"
    #retry
    #deepdupes
  end

  def in_bounds?(pos)
    pos.all? {|el| el.between?(0,7)}
  end

end
