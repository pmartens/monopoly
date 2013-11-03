module Game
  class Die
  
    attr_accessor :value
  
    protected :value
  
    def throw_dice
      @value.sample.to_int
    end
    
  end  
end