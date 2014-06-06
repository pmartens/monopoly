module Game
  module Space
    module Action
      module Condition

        # Condition that is always true
        class OnTargetPosition < Condition

          def initialize(boardgame)
            super(boardgame)
            @round = 0
          end

          def satisfy(space)
            p = get_target_position
            # after check target position
            @round = @round == get_board_rounds ? 0 : @round + 1 if get_board_rounds > 0
            execute_space_actions? && @boardgame.gameboard.space_index(space) == p
          end

          :private

          def get_target_position
            # determine new position
            t = get_new_position
            if get_board_rounds > 0
              if @round == get_board_rounds
                t = get_new_position - (@boardgame.gameboard.space_count * get_board_rounds)
              end
            end
            # when player target position is max space postion, player start_spec.rb at position 0
            t = 0 if t == @boardgame.gameboard.space_count
            t
          end

          def get_new_position
            @boardgame.active_player.position + @boardgame.settings.dice.value
          end

          def get_board_rounds
            get_new_position / @boardgame.gameboard.space_count
          end

        end

      end
    end
  end
end