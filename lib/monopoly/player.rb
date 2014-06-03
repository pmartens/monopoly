module Monopoly
  class Player < Game::Player
    
    attr_reader :money
    
    def reset
      super
      @money = 0
    end
    
    def receive_money(money)
      @money += money if money > 0
      money
    end
     
    def pay_money(money)   
      @money = @money - money if money > 0
      money
    end 
    
    def bankrupt?
      @money < 0
    end
    
  end
end