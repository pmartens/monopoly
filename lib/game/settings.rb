module Game
  class Settings
    attr_accessor :players
    attr_accessor :gameboard
    attr_accessor :dice
    attr_accessor :min_players
    attr_accessor :max_players
    
    protected :players, :gameboard, :dice, :min_players, :max_players
    
    def initialize(players)
      @players = players
      @players.sort! { |a,b| a.name <=> b.name }
    end
    
  end
end