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
      if possible_pos?(new_pos)
        possible_moves << new_pos
      end
    end
    
    possible_moves
  end

  def attacking?(pos)
    board[pos].color != color
  end

  def empty_space?(pos)
    board[pos].empty?
  end

  def possible_pos?(pos)
    on_board?(pos) && (attacking?(pos) || empty_space?(pos))
  end

end
