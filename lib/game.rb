class Game
  attr_accessor :board, :player_1, :player_2


  WIN_COMBINATIONS = [
    [0,1,2], #top row
    [3,4,5], #middle row
    [6,7,8], #bottom row
    [0,4,8], #diagonal from top left corner
    [2,4,6], #diagonal from top right corner
    [0,3,6], #left column
    [1,4,7], #middle column
    [2,5,8] #right column
  ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @board = board
    @player_1 = player_1
    @player_2 = player_2
  end

  def current_player
    @board.turn_count % 2 == 1 ? player_2 : player_1
    end

  def won?
    winner = WIN_COMBINATIONS.detect {|win_comb| win_comb.all? {|i| board.cells[i] == "X"} || win_comb.all? {|i| board.cells[i] == "O"}}
    winner || false
   end

  def draw?
    !won? && board.full?
  end

  def over?
    draw? || won?
  end

  def winner
    if won?
      winner_arr_firstindex = won?[0]
      board.cells[winner_arr_firstindex] == "X" ? "X" : "O"
    else
      nil
    end
  end

  def turn
    input = current_player.move(@board)
    if @board.valid_move?(input)
      @board.update(input, current_player)
    else
      puts "Please enter a valid move."
      turn
    end
    @board.display
  end

  def play
    until over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

end
