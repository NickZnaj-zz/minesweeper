require_relative 'tiles'
require_relative 'board'
require 'byebug'

class Game
  attr_reader :board

  def initialize(size, mines)
    @board = Board.new(size, mines)
  end

  def take_guess
    puts "Enter r for reveal or f for flag followed by coordinates. (r 3,2)."
    input = gets.chomp
    input = input.split(" ")
    action = input[0]
    position = input[1].split(",").map(&:to_i)
    implement_guess(action, position)
  end

  def implement_guess(action,position)
    this_tile = board[position]
    case action
    when "r"
      this_tile.reveal = true
      board.reveal_neighbors(this_tile)
    when "f"
      this_tile.flag = true
    end
  end



end


if __FILE__ == $PROGRAM_NAME

end
