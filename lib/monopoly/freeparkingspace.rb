module Monopoly
  class FreeParkingSpace < Space

    def name
      "freeparking"
    end
        
    def land_action(player, pot)
      player.receive_money(pot.money_out)
    end
    
  end
end