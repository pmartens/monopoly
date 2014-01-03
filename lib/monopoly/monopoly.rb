module Monopoly
  class Monopoly < Game::BoardGame

    attr_reader :pot

    def initialize(settings)
      @pot = Pot.new
      @settings = settings
      super(settings, MonopolyBoard.new(self))
    end

    def restart_game
      super
      @settings.players.each do |player|
        player.receive_money(1500)
      end
    end

    def winner
      count = 0
      winner = nil
      @settings.players.each do |player|
        if !player.bankrupt?
          count += 1
          winner = player
        end
      end
      count == 1 ? winner : nil
    end

    protected

    def next_player
      super unless @settings.dice.double?
    end

  end
end