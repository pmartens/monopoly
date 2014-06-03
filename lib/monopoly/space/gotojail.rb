module Monopoly
  module Space
    class GoToJail < Space

      def initialize(monopoly, jail)
        @jail = jail
        super( monopoly, "go to jail")
      end

      def land_action
        @jail.to_jail
      end

    end
  end
end