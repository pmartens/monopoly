module Game
  class BoardGame

    attr_reader :settings
    attr_reader :gameboard

    def initialize(settings, gameboard = nil)
      @settings = settings
      @gameboard = gameboard.nil? ? GameBoard.new(self) : gameboard
      restart_game
    end

    def restart_game
      @throw_indentifier = 0
      @active_player = 0
    end

    def winner
      nil
    end

    def active_player
      @settings.players[@active_player]
    end

    def throw_dice
      raise "game played" if winner.present?

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

      # execute before actions
      curpos = 0
      while curpos <= @settings.gameboard.space_count do
        @settings.gameboard.space(curpos).before_action
      end

      # check if player can move position
      can_move = true
      curpos = 0
      while curpos <= @settings.gameboard.space_count and can_move do
        can_move = @settings.gameboard.space(curpos).player_can_move
      end

      # execute pass actions
      if can_move
        curpos = startpos + 1
        while curpos < topos do
          # execute space action
          @settings.gameboard.space(curpos).pass_action
          curpos += 1
          if curpos == @settings.gameboard.space_count && newpos < endpos
            curpos = 0
            topos = newpos
          end
        end
        # execute land action
        @settings.gameboard.space(newpos).land_action
      end

      # to next player
      next_player
    end

    :protected

    def next_player
      @active_player += 1
    end

  end
end