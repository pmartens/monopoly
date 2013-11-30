module Game
  class BoardGame

    attr_reader :settings

    def initialize(settings)
      @settings = settings
      restart_game
    end

    def restart_game
      @active_player = 0
    end

    def winner?

    end

    def throw_dice
      raise "game played" unless !winner?

      #binding.pry
      startpos = active_player.position
      steps = @settings.dice.throw_dice
      endpos = active_player.position + steps

      # determine new position
      newpos = endpos > @settings.gameboard.space_count ? ((@settings.gameboard.space_count - endpos).abs) : endpos
      if newpos == @settings.gameboard.space_count
        newpos = 0
      end

      # set maximum position of gameboard
      if endpos > @settings.gameboard.space_count
        topos = @settings.gameboard.space_count
      else
        topos = newpos
      end

      # execute pass actions
      curpos = startpos + 1
      while curpos < topos do
        # execute space action
        @settings.gameboard.space(curpos).pass_action(@active_player)
        curpos += 1
        if curpos == @settings.gameboard.space_count && newpos < endpos
          curpos = 0
          topos = newpos
        end
      end

      # execute land action
      @settings.gameboard.space(newpos).land_action(@active_player)

      # set player position
      active_player.position = newpos

      # to next player
      next_player
    end

    protected

    def active_player
      @settings.players[@active_player]
    end

    def next_player
      @active_player += 1
    end

  end
end