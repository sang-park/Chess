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

    direction.each do |dx, dy|
      new_pos = [pos[0] + dx , pos[1] + dy]
      while on_board?(new_pos)

        unless board[new_pos].empty?
          possible_moves << new_pos if attacking?(new_pos)
          break
        end

        possible_moves << new_pos
        new_pos = [new_pos[0] + dx , new_pos[1] + dy]
      end
    end

    possible_moves
  end

  def attacking?(pos)
    board[pos].color != color
  end

end
