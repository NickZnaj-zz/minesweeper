require_relative 'tiles'
require_relative 'board'
require 'byebug'

class Game
  attr_reader :board

  def initialize(size = 9, mines = 20)
    @board = Board.new(size, mines)
  end

  def take_guess
    puts "Enter r for reveal or f for flag followed by coordinates. (r 3,2)."
    input = gets.chomp

    #take_guess if (action != 'f') || (action != 'r')
    #take_guess if position.each {|x| !(0..board.length).include?(x) }
    input = input.split(" ")
    action = input[0]
    position = input[1].split(",").map(&:to_i)
    implement_guess(action, position)
  end

  def implement_guess(action,position)
    this_tile = board[position]
    case action
    when "r"
      if this_tile.bombed?
        abort("This is a bomb. Game over.")
      end
      this_tile.reveal = true
      board.reveal_neighbors(this_tile)
    when "f"
      this_tile.flag = true
    end
  end

  def game_over?
    board.grid.each_with_index do |row, row_idx|
      row.each do |col|
        return false if !col.bombed? && !col.revealed?
      end
    end
    true
  end

  def play

    until game_over?
      board.display
      take_guess
      system("clear")

    end
  end



end


if __FILE__ == $PROGRAM_NAME
  a = Game.new(9, 1)
  a.play
end
