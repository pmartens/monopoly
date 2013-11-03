module Monopoly
  class IncomeTaxSpace < Space

    def name
      :incometax
    end
    
    def land_value
      200
    end
  
    def land_action(player)
      player.money_pay(land_value)
    end
    
  end
end