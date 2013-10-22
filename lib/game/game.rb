class Game
  
  attr_accessor :players
  attr_accessor :gameboard
  attr_accessor :dice
  attr_accessor :min_players
  attr_accessor :max_players
  attr_accessor :turn
  attr_accessor :round
  
  def title
    puts "-- Game --\n"
  end
  
  def initialize(players)
    @players = players
    @players.sort! { |a,b| a.id <=> b.id }
    raise "play with at least #{min_players.to_s} players" unless players.count >= min_players 
    raise "Play with up to #{max_players.to_s} players" unless players.count <= max_players 
    @round = 0
  end
    
  def start( dryrun = false)
    title
    @winner = false
    @turn = Turn.new(dice)
    begin
      @round += 1
      puts "_________________________________________________"
      puts "ROUND: #{@round}"
      puts "_________________________________________________\n"
      @players.each do |player|
        @turn.next(player)
        puts "[#{player.name}]"
        puts "_________________________________________________"
        begin
          @turn.reset
          @turn.dice_throw
          player.new_position(@turn.move_position)
          player.raise_played_counter
          puts "New position: #{player.current_position}"
        end while @turn.double_dice
        puts "_________________________________________________\n"
      end
    end while !winner? && !dryrun
  end  
  
  def winner?
    @winner
  end

end