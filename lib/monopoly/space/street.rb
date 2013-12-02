module Monopoly
  module Space
    class Street < Property

      :protected

      def interest
        @properties.owns_all(@owner) ? @interest * 2 : @interest
      end

    end
  end
end