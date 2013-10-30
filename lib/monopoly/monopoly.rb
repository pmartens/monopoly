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
    @gameboard || @gameboard = MonopolyBoard.new
  end

  def min_players
    2 # Minimum of two players
  end
    
  def max_players
    8 # Maximum of 8 players
  end    
  
  def start_seed
    1500
  end
        
  def start( dryrun = false)
    super
    begin
      next_round
      @players.each do |player|
        next_player_turn(player)
        begin
          dice_throw
          move_player_position
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
  
  def move_player_position
    super
    # position starts at 0 so maximum is 1 less
    max_pos = (gameboard.spaces.count - 1)
    
    if @player.current_position < @player.previous_position
      topos = max_pos
    else
      topos = @player.current_position
    end
        
    # execute pass actions
    pos = (@player.previous_position + 1)
    
    # puts "space count: #{gameboard.spaces.count}"
    # puts "cur_pos: #{@player.current_position}"
    # puts "pre_pos: #{@player.previous_position}"
    # puts "Pos: #{pos}"
    # puts "Topos: #{topos}"
    # puts "Maxpos: #{max_pos}"
    
    while pos < topos do
       #puts "POS : #{pos}"
       puts "position:#{gameboard.spaces[pos].name}"
       @player.pay(gameboard.spaces[pos].pass_action(self))
       pos += 1
       if pos == max_pos && @player.current_position < @player.previous_position
         pos = 0
         topos = @player.current_position
       end
    end
    # execute land action
    @player.pay(gameboard.spaces[@player.current_position].land_action(self))
  end
  
  private
  
  def title
    puts "\n\n_________________________________________________"
    puts "  M O N O P O L Y"
    puts "_________________________________________________\n\n"
  end
  
  def reset
    super
    @players.each{ |player| player.money = start_seed }
  end
  
end