module Monopoly
  module Space
    class FreeParkingSpace < Game::Space

      def initialize(monopoly)
        @name = "freeparking"
        super( monopoly, name)
      end

      def land_action(player)
        player.receive_money(@boardgame.pot.money_out)
      end
    end
  end
end