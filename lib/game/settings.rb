module Game
  class Settings
    attr_accessor :players
    attr_reader :gameboard
    attr_reader :dice
    
    def initialize(players, gameboard = nil, dice = nil)
      @players = players
      @players.sort! { |a,b| a.name <=> b.name }
      @gameboard = gameboard unless gameboard.nil?
      @dice = dice unless dice.nil?
    end

  end
end