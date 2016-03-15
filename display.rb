require 'colorize'

class Display
  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
  end

  def render
    system("clear")
    @board.each_with_index do |row,i|
      rendered_row = row.map.with_index do |piece,j|
        piece_color = piece.color
        color_options = colors_for(i, j,piece_color)
        piece.to_s.colorize(color_options)
      end
      puts rendered_row.join("")
    end
    nil
  end

  def colors_for(i, j,color)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif (i + j).odd?
      bg = :light_blue
    else
      bg = :light_white
    end
    {background: bg, color: color}
  end

end
