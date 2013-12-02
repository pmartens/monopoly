module Monopoly
  module Space
    class Station < Property

      def initialize(monopoly, properties, name )
        super(monopoly, properties, name, 10, 2)
      end

      :protected

      def interest
        @properties.owns_count(@owner) * @interest
      end

    end
  end
end