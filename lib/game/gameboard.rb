module Game
  class GameBoard
  
    def initialize(settings)
      @spaces = []
    end
    
    def space(index)
      @spaces[index]
    end

    def add_space(space)
      @spaces << space
    end
    
    def space_count
      @spaces.count
    end
      
  end
end