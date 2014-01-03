module Monopoly
  module Space
    class Tax < GameSpace

      def initialize(monopoly, name, land_value)
        @name = "start"
        @land_value = land_value
        super( monopoly, name)
      end

      def land_action
        @boardgame.pot.money_in(@boardgame.active_player.pay_money(@land_value))
      end

    end
  end
end