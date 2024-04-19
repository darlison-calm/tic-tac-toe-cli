class Game
  
  attr_accessor :board
  attr_reader :current_player, :other_player

  WIN_CONDITIONS = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6] ]

  def initialize  
    @board = (0..8).to_a
    @current_player = Player.new('Player1', 'X')
    @other_player = Player.new('Player2', 'O')
  end

  def play
    loop do
      puts "#{current_player.name} (#{current_player.symbol}) turn"
      display_board

      position = current_player.select_position(board, self)
      
      self.add_to_board(position, current_player.symbol)
      
      if self.player_won?(board , current_player.symbol)    
        puts"#{current_player.name} won!" 
        display_board
        return    
      
      elsif self.board_full?(board)  
        puts "It's a draw!"
        display_board
        return
      
      else 
        self.switch_players

      end
    end
  end

  def display_board
    puts"\n"
    puts "#{board[0]} | #{board[1]} | #{board[2]}"
    puts "----------"
    puts "#{board[3]} | #{board[4]} | #{board[5]}"
    puts "----------"
    puts "#{board[6]} | #{board[7]} | #{board[8]}"
  end
  
  private
  
  def add_to_board(cord, symbol)
    
    self.board[cord] = symbol
  end
  

  def player_won?(board,symbol)
    WIN_CONDITIONS.any? do |conditions|
      conditions.all? {|position| board[position] == current_player.symbol}
    end
  end

  def board_full?(board)
    board.all?{|position| position == current_player.symbol || position == other_player.symbol }
  end

  def switch_players 
    @current_player , @other_player =  @other_player, @current_player
  
  end
end

class Player
  
  attr_reader :symbol, :name
  
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
  
  def select_position(board, game)
    
    loop do
      puts"\n"
      puts "Select your #{symbol} position: "
      selection = gets.chomp.to_i
      
      if board[selection].is_a?(Integer) && selection.between?(0, 8) && selection.is_a?(Integer)
        return selection  
      end
      puts "Position #{selection} is not available. Try again."
      game.display_board
    end
  end
end

game = Game.new
game.play
