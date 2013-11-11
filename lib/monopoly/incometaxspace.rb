module Monopoly
  class IncomeTaxSpace < Space

    def name
      "incometax"
    end
    
    def land_value
      200
    end
  
    def land_action(player, pot)
      pot.money_in(player.pay_money(land_value))      
    end
    
  end
end