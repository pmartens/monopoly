module Monopoly
  class FreeParkingSpace < Space

    def name
      :freeparking
    end
        
    def land_action(player)
      player.receive_money(@game.gameboard.pot.money_out)
    end
    
  end
end