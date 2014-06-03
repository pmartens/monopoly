module Monopoly
  module Space
    class Street < Property::Property

      :protected

      def interest
        @propertygroup.owns_all(@owner) ? @interest * 2 : @interest
      end

    end
  end
end