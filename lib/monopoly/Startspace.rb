class StartSpace < MonopolySpace
  
  def name
    :start
  end
  
  def pass_value
    100
  end
  
  def land_value
    200
  end
  
  def pass_action(monopoly)
    monopoly.round? > 1 ? pass_value : 0
  end

  def land_action(monopoly)
    land_value
  end
end