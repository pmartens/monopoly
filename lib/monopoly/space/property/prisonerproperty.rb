module Monopoly
  module Space
    module Property
      class PrisonerProperty

        attr_accessor :player
        attr_accessor :last_changed
        attr_accessor :locked_up
        attr_accessor :locked_up_throws
        attr_accessor :double_throws

        def initialize(player)
          @player = player
          release
        end

        def release
          @locked_up = false
          @locked_up_throws = 0
          @double_throws = 0
        end

        def lock_up
          @locked_up = true
          @locked_up_throws = 0
          @double_throws = 0
        end

      end

    end
  end
end