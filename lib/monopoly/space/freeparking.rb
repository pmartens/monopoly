module Monopoly
  module Space
    class FreeParking < GameSpace

      def initialize(monopoly)
        super( monopoly, "freeparking")
      end

      def land_action
        @boardgame.active_player.receive_money(@boardgame.pot.money_out)
      end
    end
  end
end