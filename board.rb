
class Board

  # BACK_ROW = [
  #   :rook,
  #   :knight,
  #   :bishop,
  #   :queen,
  #   :king,
  #   :bishop,
  #   :knight,
  #   :rook
  # ]
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
    [0,7].each do |i|
      self[[i, 0]] = Rook.new(self, [i, 0])
      self[[i, 7]] = Rook.new(self, [i, 7])
      self[[i, 1]] = Knight.new(self, [i, 1])
      self[[i, 6]] = Knight.new(self, [i, 6])
      self[[i, 2]] = Bishop.new(self, [i, 2])
      self[[i, 5]] = Bishop.new(self, [i, 5])
      self[[i, 3]] = Queen.new(self, [i, 3])
      self[[i, 4]] = King.new(self, [i, 4])
    end
  end

  def move(start_pos,end_pos)
    raise "no piece at start pos" if self[start_pos].nil?
    raise "cannot move to end" unless self[end_pos].nil?
  rescue => e
    puts "#{e.message}. Try again"
    #retry
  end

  def in_bounds?(pos)
    pos.all? {|el| el.between?(0,7)}
  end

end
