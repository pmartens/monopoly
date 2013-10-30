class Game
  
  attr_accessor :players
  attr_accessor :gameboard
  attr_accessor :dice
  attr_accessor :min_players
  attr_accessor :max_players
  
  attr_accessor :score
  attr_accessor :round
    
  def initialize(players)
    @players = players
    @players.sort! { |a,b| a.id <=> b.id }
    raise "play with at least #{min_players.to_s} players" unless players.count >= min_players 
    raise "Play with up to #{max_players.to_s} players" unless players.count <= max_players 
    reset
  end
    
  def round?
    @round || 0
  end
  
  def winner?
    @winner
  end
  
  def start( dryrun = false)
    reset
    title
  end  
      
  def next_player_turn(player)
    @player = player
    puts "[#{player.name}]"
    puts "_________________________________________________"
  end
  
  def turn_player
    @player
  end
  
  def dice_throw
    @score = []
    dice.each do |die|
      @score << { die => die.faces.sample.value }
    end
    @score.each{ |data| data.each{ |key, value| puts "Die score: #{value}"}}
    puts "Total Dice score: #{turn_dice_score.to_s}"
  end
  
  def turn_dice_score
    score = 0
    @score.each{ |data| data.each{ |key, value| score += value}}
    score.to_i
  end

  def turn_each_die_score
    score = []
    @score.each{ |data| data.each{ |key, value| score << value}}
    score
  end

  def move_player_position
    newpos = @player.current_position + turn_dice_score
    newpos = newpos > gameboard.spaces.count ? ((gameboard.spaces.count - newpos).abs - 1) : newpos
    if newpos == gameboard.spaces.count
      newpos = 0
    end
    
    @player.new_position(newpos)
  end
  
  private
  
  def title
    puts "\n\n_________________________________________________"
    puts "  G A M E"
    puts "_________________________________________________\n\n"
  end

  def reset
    @round = 0
    @winner = false
  end
  
  def next_round
    @round += 1
    puts "_________________________________________________"
    puts "ROUND: #{@round}"
    puts "_________________________________________________\n"
  end

end