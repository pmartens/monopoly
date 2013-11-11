module Monopoly
  class StartSpace < Space
  
    def name
      "start"
    end
  
    def pass_value
      100
    end
  
    def land_value
      200
    end
    
    def pass_action(player)
      player.receive_money(pass_value)
    end
    
    def land_action(player)
      player.receive_money(land_value)
    end
    
  end
end