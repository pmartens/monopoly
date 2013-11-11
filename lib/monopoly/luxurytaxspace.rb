module Monopoly
  class LuxuryTaxSpace < Space
  
    def name
      "luxurytax"
    end
    
    def land_value
      100
    end
    
    def land_action(player, pot)
      pot.money_in(player.pay_money(land_value))
    end
    
  end  
end