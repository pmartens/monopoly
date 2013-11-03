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
  
    def active_player
      @active_player
    end
  
    def throw_dice
      player = @players[@active_player]
      startpos = player.position
      steps = @dice.throw_dice
      endpos = player.position + steps
      
      # determine new position
      newpos = endpos > gameboard.spaces_count ? ((gameboard.spaces_count - endpos).abs) : endpos
      if newpos == gameboard.spaces_count
        newpos = 0
      end
    
      # set maximum position of gameboard
      if endpos > gameboard.space_count
        topos = gameboard.space_count
      else
        topos = newpos
      end
        
      # execute pass actions
      curpos = startpos + 1
      while curpos < topos do
        # execute space action
        space_action(gameboard.space(curpos))
        curpos += 1
        if curpos == gameboard.space_count && newpos < endpos
          curpos = 0
          topos = newpos
        end
      end
 
      # execute land action
      land_action(gameboard.space(newpos))

      # set player position
      player.position = newpos  
      
      # to next player
      next_player
    end
  
    protected
  
    def pass_action(space)
      space.pass_action(@player)
    end
  
    def land_action(space)
      space.land_action(@player)
    end
    
    def next_player
      @active_player += 1
    end
    
  end
end