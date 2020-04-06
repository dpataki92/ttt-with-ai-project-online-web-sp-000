module Players
  class Human < Player
    def move(board)
      if board.turn_count == 0
        board.display
        puts "Please make a move:"
        gets.strip
      else
        puts "Please make a move:"
        gets.strip
      end
    end
  end
end
