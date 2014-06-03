module Game
  class GameBoard

    attr_reader :space_action_executor

    def initialize(boardgame)
      @boardgame = boardgame
      @spaces = []
    end

    def set_space_action_executor(space_action_executor)
      @space_action_executor = space_action_executor
    end

    def space(index)
      @spaces[index]
    end

    def spaces(classname)
      spaces = []
      @spaces.each do |space|
        spaces << space if space.class == classname
      end
      spaces
    end

    def add_space(space)
      @spaces << space
    end

    def space_count
      @spaces.count
    end

    def space_index(space)
      @spaces.index(space)
    end

  end
end