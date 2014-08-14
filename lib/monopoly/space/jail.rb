module Monopoly
  module Space
    class Jail < Space

      def initialize(monopoly)
        @prisonerproperties = []
        monopoly.settings.players.each { |player| @prisonerproperties << Property::PrisonerProperty.new(player) }
        super( monopoly, "Jail")
      end

      def always_action
        p = prisonerproperty
        p.double_throws = 0 if !p.double_throws == 3
        p.double_throws = @boardgame.settings.dice.double? ? + 1 : 0
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
        p.locked_up ? false : true
      end

      def prisonerproperty
        @prisonerproperties.each { |p| return p if p.player == @boardgame.active_player }
      end

      def to_jail
        p = prisonerproperty
        p.lock_up
        @boardgame.active_player.position = @boardgame.gameboard.space_index(self)
      end

    end
  end
end