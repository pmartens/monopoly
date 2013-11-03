module Monopoly
  class Pot
  
    attr_accessor :money
    
    private :money
  
    def money
      @money
    end
  
    def initialize
      @money = 0
    end
        
    def money_out
      m = @money
      @money = 0
      m
    end
  
    def money_in(amount)
      @money += amount unless amount < 0
    end
    
  end   
end