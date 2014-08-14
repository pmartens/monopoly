module Game
  module Space
    module Action
      module Condition
        class Chain < Satisfiable

          def initialize
            @conditions = []
          end

          def add_condition(condition)
            @conditions << condition
          end

          def satisfy(space)
            @conditions.each { |condition| return false unless condition.satisfy(space) }
            true
          end

        end
      end
    end
  end
end