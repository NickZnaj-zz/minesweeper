require_relative 'tiles'
require 'byebug'

class Board
  attr_accessor :grid, :size,:mines
  def initialize(size = 9, mines = 20)
    @size = size
    @mines = mines
    @grid = Array.new(size) do |row|
      Array.new(size) do |col|
        Tile.new(row, col)
      end
    end
    assign_mines
  end

  def [](pos)
    x, y = pos
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


end

Board.new
