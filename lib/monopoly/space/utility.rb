module Monopoly
  module Space
    class Utility < Property

      def initialize(monopoly, properties, name = nil)
        @owner = nil
        @properties = properties
        @sale_price = 10
        super(monopoly, name)
      end

      private:

      def interest
        @properties.owns_all(@owner) ? 10 : 4) * @settings.dice.value
      end

    end
  end
end