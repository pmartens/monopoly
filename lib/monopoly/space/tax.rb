module Monopoly
  module Space
    class Tax < Game::Space

      def initialize(monopoly, name, land_value)
        @name = "start"
        @land_value = land_value
        super( monopoly, name)
      end

      def land_action(player)
        @boardgame.pot.money_in(@boardgame.settings.player.pay_money(@land_value))
      end

    end
  end
end