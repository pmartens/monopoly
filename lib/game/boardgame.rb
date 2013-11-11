module Game
  class BoardGame
  
    attr_accessor :settings
    attr_accessor :active_player
    
    private :settings, :active_player
  
    def initialize(settings)
      @settings = settings
      restart_game
    end

    def restart_game
      @active_player = 0
    end
      
    #def winner?
    #  @player
    #end   
    
    def throw_dice
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
        space_action(@settings.gameboard.space(curpos))
        curpos += 1
        if curpos == @settings.gameboard.space_count && newpos < endpos
          curpos = 0
          topos = newpos
        end
      end
 
      # execute land action
      land_action(@settings.gameboard.space(newpos))

      # set player position
      active_player.position = newpos  
      
      # to next player
      next_player
    end
  
    protected
  
    def active_player
      @settings.players[@active_player]
    end
  
    def pass_action(space)
      space.pass_action(@active_player)
    end
  
    def land_action(space)
      space.land_action(@active_player)
    end
    
    def next_player
      @active_player += 1
    end
    
  end
end