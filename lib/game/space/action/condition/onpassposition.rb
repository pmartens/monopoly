module Game
  module Space
    module Action
      module Condition

        # Condition that is always true
        class OnPassPosition < OnTargetPosition

          def initialize(boardgame)
            super(boardgame)
            @previous_space_position = 0
          end

          def satisfy(space)
            s = @boardgame.gameboard.space_index(space)
            p = @boardgame.active_player.position
            execute_space_actions? && ( get_board_rounds == 0 && s != p && s != get_target_position)
          end

        end
      end
    end
  end
end