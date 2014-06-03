module Monopoly
  module Space
    class Station < Property::Property

      def initialize(monopoly, propertygroup, name )
        super(monopoly, propertygroup, name, 10, 2)
      end

      :protected

      def interest
        @propertygroup.owns_count(@owner) * @interest
      end

    end
  end
end