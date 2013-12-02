module Game
  class Settings

    attr_reader :players
    attr_reader :dice

    def initialize(players, dice)
      @players = players
      @players.sort! { |a,b| a.name <=> b.name }
      @dice = dice
    end

  end
end