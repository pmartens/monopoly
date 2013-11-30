module Monopoly
  module Space
    class Start < Space

      def initialize(monopoly)
        @name = "start"
        super( monopoly, name)
      end

      def pass_action(player)
        player.receive_money(pass_value)
      end

      def land_action(player)
        player.receive_money(land_value)
      end

      private:

      def pass_value
        100
      end

      def land_value
        200
      end

    end
  end
end