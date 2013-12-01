module Monopoly
  class Monopoly < Game::BoardGame

    attr_reader :pot

    def initialize(settings)
      @pot = Pot.new
      super(settings, MonopolyBoard.new(self))
    end

    def restart_game
      super
      @settings.players.each do |player|
        player.receive_money(@settings.start_fund)
      end
    end

    def winner?
      count = 0
      @settings.players.each do |player|
         count += 1 unless player.bankrupt?
      end
      count == 1
    end

    protected

    def next_player
      super unless @settings.dice.double?
    end

  end
end