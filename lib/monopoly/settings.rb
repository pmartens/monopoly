module Monopoly
  class Settings < Game::Settings

    attr_reader :gameboard
    attr_reader :dice

    def start_fund
      1500
    end

    def initialize(players)
      raise "play with at least 2 players" unless players.count > 1
      raise "Play with up to 8 players" unless players.count < 9
      @gameboard = MonopolyBoard.new
      @dice = Game::DuoTraditionalDice.new
      super
    end

  end
end