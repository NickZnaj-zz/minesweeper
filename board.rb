require_relative 'tiles'
require 'byebug'

class Board
  attr_accessor :grid, :size, :mines
  def initialize(size = 9, mines = 20)
    @size = size
    @mines = mines
    @grid = Array.new(size) do |row|
      Array.new(size) do |col|
        Tile.new(row, col)
      end
    end
    assign_mines
    add_bomb_count
  end

  def [](pos)
    x, y = pos
    if x.is_a?(Array) || y.is_a?(Array)
      debugger
    end
    @grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end

  def assign_mines
    count_mines = 0
    #debugger
    until count_mines == mines
      pos = [rand(0...grid.length), rand(0...grid.length)]
      if !self[pos].bombed?
        self[pos].bomb = true
        count_mines += 1
      end
    end
  end

  def find_neighbors(tile)
    neighbor_tiles = grid.flatten.select {|pn| tile.row >= pn.row - 1 &&
    tile.row <= pn.row + 1 &&
    tile.col >= pn.col - 1 &&
    tile.col <= pn.col + 1 &&
    tile.object_id != pn.object_id}
  end

  def add_bomb_count
    @grid.each_with_index do |row, row_idx|
      row.each_index do |col|
        this_tile = self[[row_idx, col]]
        if this_tile.bombed?
          find_neighbors(this_tile).each {|tile| tile.neighbor_bomb_count}
        end
      end
    end
  end

  def reveal_neighbors(tile)
    find_neighbors(tile).each do |t|
      t.reveal = true
      reveal_neighbors(t) if !t.bombed? && !t.flagged?
    end
  end

  def display
    @grid.each_with_index do |row, row_idx|
      disp_str = ""
      row.each do |col|
        if !col.revealed?
          disp_str << "|*|"
        elsif col.revealed? && col.bomb_count == 0
          disp_str << "|_|"
        elsif col.revealed?
          disp_str << "|#{col.bomb_count}|"
        elsif col.flagged?
          disp_str << "|F|"
        end
      end
      puts disp_str
    end

  end


end

if __FILE__ == $PROGRAM_NAME
  a = Board.new()
  a.display
end
