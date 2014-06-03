module Game
  module Space
    class SpaceAction

      attr_reader :name

      def initialize(name)
        @name = name
        @condition_chain = Game::Space::Action::Condition::Chain.new
      end

      def add_condition(condition)
        @condition_chain.add_condition(condition)
      end

      def execute(space)
        space.execute_action(@name) if @condition_chain.satisfy(space)
      end

    end
  end
end

