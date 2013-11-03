module Monopoly
  class Space < Game::Space
    
    attr_reader :pass_value
    attr_reader :land_value

    protected :pass_value, :land_value
    
    def pass_value
      0
    end
  
    def land_value
      0
    end

    def pass_action(player)
      #player.pay_money(pass_value)
    end
    
    def land_action(player)
      #player.pay_money(pass_value)
    end
    
  end
end