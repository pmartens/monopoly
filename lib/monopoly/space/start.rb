module Monopoly
  module Space
    class Start < Game::Space

      def initialize(monopoly)
        @name = "start"
        super( monopoly, name)
      end

      def pass_action(player)
        player.receive_money(100)
      end

      def land_action(player)
        player.receive_money(200)
      end

    end
  end
end