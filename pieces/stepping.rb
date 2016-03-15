module Stepping
  KING = [
    [-1, -1],
    [-1,  1],
    [ 1, -1],
    [ 1,  1],
    [ 0, -1],
    [ 0,  1],
    [-1,  0],
    [ 1,  0]
  ]

  KNIGHT = [
   [-2, -1],
   [-2,  1],
   [-1, -2],
   [-1,  2],
   [ 1, -2],
   [ 1,  2],
   [ 2, -1],
   [ 2,  1]
 ]

  def moves(direction)
    possible_moves = []
    cur_x, cur_y = pos
    direction.each do |(dx, dy)|
      new_pos = [cur_x + dx, cur_y + dy]
      possible_moves << new_pos if self.on_board?(new_pos)
    end
    possible_moves
  end

end
