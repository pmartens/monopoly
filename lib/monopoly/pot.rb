class Pot
  
  attr_accessor :money
  
  def money
    @money
  end
  
  def initialize
    @money = 0
  end
        
  def out
    m = @money
    @money = 0
    m
  end
  
  def in(amount)
    @money += amount
  end
     
end