module Game
  class GameBoard

    def initialize(boardgame)
      @boardgame = boardgame
      @spaces = []
    end

    def space(index)
      @spaces[index]
    end

    def spaces(name)
      spaces = []
      @spaces.each do |space|
        spaces << space if space.name == name
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