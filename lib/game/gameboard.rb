module Game
  class GameBoard
  
    attr_accessor :spaces
    
    protected :spaces
    
    def space(id)
      @spaces[id]
    end
      
    protected
    
    def spaces
      @spaces || @spaces = []
    end
    
    def add_space(space)
      @spaces << space
    end
      
  end
end