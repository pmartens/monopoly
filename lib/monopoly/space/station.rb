module Monopoly
  module Space
    class Station < Property

      def initialize(monopoly, properties, name = nil )
        @sale_price = 10
        @interest = 2
        super(monopoly, properties, name, saleprice, interest)
      end

      private:

      def interest
        @properties.owns_count(@owner) * @interest
      end

    end
  end
end