module Monopoly
  class Settings < Game::Settings

    def initialize(players)
      raise "play with at least 2 players" unless players.count > 1
      raise "Play with up to 8 players" unless players.count < 9
      @dice = Game::DuoTraditionalDice.new
      super
    end

  end
end