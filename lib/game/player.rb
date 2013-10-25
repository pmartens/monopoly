class Player
  attr_accessor :id
  attr_accessor :name
  attr_accessor :played
  attr_accessor :previous_position
  attr_accessor :current_position

  @@player_counter = 0
  
  def initialize(name)
    raise "Player name empty!" unless !name.empty?
    @@player_counter += 1
    @id = @@player_counter
    @name = name
    reset_play_settings
  end
  
  def reset_play_settings
    @current_position = 0
    @previous_position = 0
    @played = 0
  end
  
  def count
    @@player_counter
  end
  
  def raise_played_counter
    @played += 1
  end
  
  def new_position( newpos )
    @previous_position = @current_position
    #@current_position += newpos 
    @current_position = newpos 
  end
  
end