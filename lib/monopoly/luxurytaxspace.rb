class LuxuryTaxSpace < MonopolySpace
  
  def name
    :luxurytax
  end
  
  def pass_value
    0
  end
  
  def land_value
    -100
  end
  
  def pass_action(monopoly)
    pass_value
  end

  def land_action(monopoly)
    monopoly.gameboard.pot.in(land_value.abs)
    land_value
  end

end