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
            @conditions.each do |condition|
              return false if !condition.satisfy(space)
              return true
            end
          end

        end
      end
    end
  end
end