module Monopoly
  module Space
    class Jail < Space

      def initialize(monopoly)
        @prisonerproperties = []
        monopoly.settings.players.each do |player|
          @prisonerproperties << Property::PrisonerProperty.new(player)
        end
        super( monopoly, "Jail")
      end

      def always_action
        p = prisonerproperty
        p.double_throws = 0 if !p.double_throws == 3
        if @boardgame.settings.dice.double?
          p.double_throws += 1
        else
          p.double_throws = 0
        end
      end

      def start_action
        p = prisonerproperty
        # action if player is prisoner
        if p.locked_up
          if p.locked_up_throws < 2
            if @boardgame.settings.dice.double?
              p.release
              p.locked_up_throws = 0
            else
              p.locked_up_throws += 1
            end
          else
            @boardgame.pot.money_in(@boardgame.active_player.pay_money(50))
            p.release
          end
        # actions if player is NO prisoner
        elsif p.double_throws == 3
          p.lock_up
          p.double_throws = 0
          @boardgame.active_player.position = @boardgame.gameboard.space_index(self)
        end
        return p.locked_up ? false : true
      end

      def prisonerproperty
        @prisonerproperties.each do |p|
          return p if p.player == @boardgame.active_player
        end
      end

      def to_jail
        p = prisonerproperty
        p.lock_up
        @boardgame.active_player.position = @boardgame.gameboard.space_index(self)
      end

    end
  end
end