module Sliding
  DIAGONAL = [
    [-1, -1],
    [-1,  1],
    [ 1, -1],
    [ 1,  1]
  ]

  LINEAR = [
    [ 0, -1],
    [ 0,  1],
    [-1,  0],
    [ 1,  0]
  ]

  def moves(direction)
    possible_moves = []
    direction.each do |dir|
      new_pos = pos
      while true
        new_pos = [new_pos[0] + dir[0] , new_pos[1] + dir[1]]
        break unless self.valid_moves?(new_pos)
        possible_moves << new_pos
      end
    end
    possible_moves
  end
end
