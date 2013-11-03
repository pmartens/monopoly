module Game
  class Space
    
    attr_accessor :name
    attr_accessor :game
    
    protected :name, :game
    
    def initialize(name, game)
      @name = name
      @game = game
    end
    
    def pass_action
    end
    
    def land_action
    end
    
    def name
      @name
    end
    
  end
end