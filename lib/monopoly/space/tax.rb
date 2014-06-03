module Monopoly
  module Space
    class Tax < Space

      def initialize(monopoly, name, land_value)
        @name = "Tax" if name.nil?
        @land_value = land_value
        super( monopoly, name)
      end

      def land_action
        @boardgame.pot.money_in(@boardgame.active_player.pay_money(@land_value))
        super
      end

    end
  end
end