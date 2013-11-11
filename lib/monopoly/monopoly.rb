module Monopoly
  class Monopoly < Game::BoardGame

    attr_accessor :pot
    
    protected :pot

    def initialize(settings)
      super
      @pot = Pot.new
      set_players_start_fund
    end  
  
    protected
      
    def set_players_start_fund
      @settings.players.each do |player|
        player.receive_money(@settings.start_fund)
      end
    end
  
    def next_player
      super unless @settings.dice.double?
    end
    
    def pass_action(space)
      space.pass_action(@player, @pot)
    end
  
    def land_action(space)
      space.land_action(@player, @pot)
    end
    
  end  
end