
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
      # After restart game each player has $1500
      @settings.players.each do |player|
        player.receive_money(1500)
      end
    end

    def winner
      winner = []
      @settings.players.each do |player|
        winner << player if !player.bankrupt?
      end
      return winner.first if winner.count == 1
    end

    protected

    def next_player
      super unless @settings.dice.double?
    end

  end
end