module Monopoly
  module Space
    class Start < Space

      def initialize(monopoly)
        @name = "start"
        super( monopoly, name)
      end

      def pass_action
        @boardgame.active_player.receive_money(100)
      end

      def land_action
        @boardgame.active_player.receive_money(200)
        super
      end

    end
  end
end