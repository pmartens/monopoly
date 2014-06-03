module Monopoly
  module Space
    class Utility < Property::Property

      def initialize(monopoly, propertygroup, name)
        super(monopoly, propertygroup, name, 10, 0)
      end

      :protected

      def interest
        (@propertygroup.owns_all(@owner) ? 10 : 4) * @boardgame.settings.dice.value
      end

    end
  end
end