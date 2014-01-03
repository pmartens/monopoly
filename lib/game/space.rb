module Game
  class Space

    attr_reader :name

    def initialize(boardgame, name)
      @name = name
      @boardgame = boardgame
    end

    def player_can_move
      true
    end

    def before_action
    end

    def pass_action
    end

    def land_action
      player.position = @boardgame.gameboard.space_index(self)
    end

  end
end