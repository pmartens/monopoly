module Monopoly
  class LuxuryTaxSpace < Monopoly::Space
  
    def name
      "luxurytax"
    end
    
    def land_value
      100
    end
    
    def land_action(player)
      @game.gameboard.pot.money_in(player.pay_money(land_value))
    end
    
  end  
end