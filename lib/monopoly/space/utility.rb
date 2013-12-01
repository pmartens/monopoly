module Monopoly
  module Space
    class Utility < Property

      def initialize(monopoly, properties, name)
        super(monopoly, properties, name, 10, 0)
      end

      :protected

      def interest
        (@properties.owns_all(@owner) ? 10 : 4) * @boardgame.settings.dice.value
      end

    end
  end
end