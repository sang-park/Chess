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
        break unless self.on_board?(new_pos)
        if !self.board[new_pos].empty?
          if self.board[new_pos].color != color
            possible_moves << new_pos #include position if attacking opponent
          end
          break
        end
        possible_moves << new_pos
      end
    end
    possible_moves
  end

end
