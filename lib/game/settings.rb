module Game
  class Settings
   
    attr_reader :players
    attr_reader :gameboard
    attr_reader :dice
    
    def initialize(players)
      @players = players
      @players.sort! { |a,b| a.name <=> b.name }
    end

  end
end