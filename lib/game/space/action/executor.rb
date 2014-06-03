module Game
  module Space
    module Action
      class Executor

        def initialize(boardgame, default_actionlist)
          @stack = []
          @boardgame = boardgame
          @default_action_list = default_actionlist
          @halt = false
        end

        def add_extra_throw(actionlist=nil)
          @stack.push(actionlist.nil? ? @default_action_list : actionlist )
        end

        def execute
          add_extra_throw if @stack.empty?
          action_list = @stack.pop
          action_list.each do |action|
            for i in 0..(@boardgame.gameboard.space_count-1)
              action.execute(@boardgame.gameboard.space(i))
            end
          end
        end

        def halt?
          return @halt
        end

        def turn_finished?
          return true if @stack.empty?
        end

      end
    end
  end
end