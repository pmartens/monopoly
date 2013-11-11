module Game
  class Player

    attr_accessor :name
    attr_accessor :position
    attr_accessor :money
    
    protected :name, :money
  
    def initialize(name)
      raise "Player name empty!" unless !name.empty?
      @name = name
      reset
    end  
    
    def name
      @name
    end
    
    def money
      @money
    end
    
    def reset
      @money = 0
      @position = 0      
    end
    
    def receive_money(money)
      @money += money
      money
    end
     
    def pay_money(money)   
      @money = @money - money
      money
    end 
  end    
end