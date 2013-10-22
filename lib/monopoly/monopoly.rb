class Monopoly < Game

  def title
    puts "\n\n_________________________________________________"
    puts "  M O N O P O L Y"
    puts "_________________________________________________\n\n"
  end
  
  def dice
    # Using two traditional dice
    dice = []
    (1..2).each do
      dice << TraditionalDie.new
    end
    dice
  end
  
  def gameboard
    MonopolyBoard.new
  end

  def min_players
    # Minimum of two players
    2
  end
    
  def max_players
    # Maximum of 8 players
    8
  end    
    
end