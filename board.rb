class Board
  attr_accessor :grid, :size,:mines
  def initialize(size = 9, mines = 20)
    @size = size
    @mines = mines
    @grid = Array.new(size) { Array.new(size) }
    populate_board
  end


end
