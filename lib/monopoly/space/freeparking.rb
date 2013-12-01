module Monopoly
  module Space
    class FreeParking < Game::Space

      def initialize(monopoly)
        super( monopoly, "freeparking")
      end

      def land_action(player)
        player.receive_money(@boardgame.pot.money_out)
      end
    end
  end
end