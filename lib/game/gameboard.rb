module Game
  class GameBoard
  
    attr_accessor :spaces
    
    protected :spaces
    
    def initialize
      @spaces = []
    end
    
    def space(id)
      @spaces[id]
    end

    def add_space(space)
      @spaces << space
    end
    
    def space_count
      @spaces.count
    end
      
  end
end