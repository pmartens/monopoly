module Monopoly
  module Space
    class Start < GameSpace

      def initialize(monopoly)
        @name = "start"
        super( monopoly, name)
      end

      def pass_action
        @boardgame.active_player.receive_money(100)
      end

      def land_action(player)
        @boardgame.active_player.receive_money(200)
      end

    end
  end
end