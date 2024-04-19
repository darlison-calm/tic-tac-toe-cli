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

      position = current_player.select_position(board, self)
      
      self.add_to_board(position, current_player.symbol)
      
      if self.player_won?(board , current_player.symbol)    
        puts"#{current_player.name} won!" 
        display_board
        return    
      
      elsif self.board_full?
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
  
  def allowed_place(selection)
    self.board[selection].is_a?(Integer)

  end

  def player_won?(board, pick)
    WIN_CONDITIONS.any? do |conditions|
      conditions.all? {|position| board[position] == pick}
    end
  end
  
  def board_full?
    self.board.all?{|position| position == 'X' || position == 'O' }
  end
  
  private
  
  def add_to_board(cord, symbol)
    
    self.board[cord] = symbol
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
      game.display_board
      puts "\nSelect your #{symbol} position: "
      selection = gets.chomp
      
      if selection.match?(/[0-8]/) && selection.size == 1
        selection = selection.to_i
        if game.allowed_place(selection)
          return selection
        else
          puts "Position already choosen"
        end
      
      else
          puts "Invalid choice"
      end
    end
  end
end

game = Game.new
game.play
