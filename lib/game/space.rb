module Game
  class Space

    attr_reader :name

    def initialize(boardgame, name)
      @name = name
      @boardgame = boardgame
    end

    def pass_action(player)
    end

    def land_action(player)
    end

  end
end