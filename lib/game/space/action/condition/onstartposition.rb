module Game
  module Space
    module Action
      module Condition

        # Condition that is always true
        class OnStartPosition < Condition

          def satisfy(space)
            return execute_space_actions? && @boardgame.gameboard.space_index(space) == @boardgame.active_player.position
          end

        end

      end
    end
  end
end