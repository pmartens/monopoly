module Monopoly
  module Space
    class AdditionalRent < Space

      attr_reader :receiver

      def initialize(monopoly, rent_percentage)
        @rent_percentage = rent_percentage
        super( monopoly, "Additional Rent")
      end

      def land_action
        @receiver = @boardgame.active_player
        super
      end

      def rent_percentage
        @rent_percentage.to_i > 0 ? @rent_percentage : 0
      end

    end
  end
end