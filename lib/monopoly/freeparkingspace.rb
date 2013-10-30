class FreeParkingSpace < MonopolySpace

  def name
    :freeparking
  end
  
  def pass_value
    0
  end
  
  def land_value
    0
  end
  
  def pass_action(monopoly)
    pass_value
  end

  def land_action(monopoly)
    monopoly.gameboard.pot.out
  end
  
end