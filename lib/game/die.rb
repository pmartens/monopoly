module Game
  class Die
  
    attr_accessor :values
  
    protected :values
  
    def initialize
      @values = []
    end
    
    def add_value(value)
      @values << value
    end
    
    def throw_die
      @values.sample.to_int
    end
        
  end  
end