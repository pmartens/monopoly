module Game
  class Space
    
    attr_accessor :name
    
    protected :name
    
    def initialize(name = nil)
      @name = name
    end
    
    def pass_action(player)
    end
    
    def land_action(player)
    end
    
    def name
      @name
    end
    
  end
end