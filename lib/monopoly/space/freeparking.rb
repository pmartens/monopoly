module Monopoly
  module Space
    class FreeParking < Space

      def initialize(monopoly)
        super( monopoly, "freeparking")
      end

      def land_action
        @boardgame.active_player.receive_money(@boardgame.pot.pay_out)
        super
      end
    end
  end
end