class Monopoly < Game
  
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
  
  def start( dryrun = false)
    reset
    begin
      next_round
      @players.each do |player|
        next_player_turn(player)
        begin
          dice_throw
          player.new_position(move_player_position)
          player.raise_played_counter
          puts "New position: #{player.current_position}"
        end while double_dice_score
        puts "_________________________________________________\n"
      end
    end while !winner? && !dryrun
  end
  
  def double_dice_score
    score = []
    @score.each{ |data| data.each{ |key, value| score.concat([value])}}
    if score.uniq.count == 1
      puts "** D O U B L E  D I C E  S C O R E **"
      true
    else
      false
    end
  end
  
  private
  
  def title
    puts "\n\n_________________________________________________"
    puts "  M O N O P O L Y"
    puts "_________________________________________________\n\n"
  end
  
end