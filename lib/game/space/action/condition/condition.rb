module Game
  module Space
    module Action
      module Condition
        class Condition < Satisfiable

          def initialize(boardgame)
            @boardgame = boardgame
          end

          def satisfy(space)
            return true
          end

          :private

          def execute_space_actions?
            raise "No space action executor defined" if @boardgame.gameboard.space_action_executor.nil?
            @boardgame.gameboard.space_action_executor.halt? ? false : true
          end

        end
      end
    end
  end
end