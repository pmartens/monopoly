
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
      @settings.players.each { |player| player.receive_money(1500) }
    end

    def winner
      winner = []
      @settings.players.each { |player| winner << player unless player.bankrupt? }
      winner.first if winner.count == 1
    end

    protected

    def next_player
      super unless @settings.dice.double?
    end

  end
end