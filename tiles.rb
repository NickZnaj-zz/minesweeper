class Tile
  attr_accessor :bomb, :bomb_count, :row, :col

  def initialize(row, col, bomb = false)
     @bomb = bomb
     @row, @col = row, col
     @bomb_count = 0 if bomb == false
  end

  def neighbor_bomb_count
    self.bomb_count += 1
  end

  def bombed?
    bomb
  end

  def reveal
    bomb_count
  end

end
