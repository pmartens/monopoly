class MonopolySpace < Space
  attr_accessor :pass_value
  attr_accessor :land_value

  def pass_value
    0
  end
  
  def land_value
    0
  end

  def land_action(monopoly)
    0
  end
  
  def pass_action(monopoly)
    0
  end   
end