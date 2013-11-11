module Game
  class Dice
  
    attr_accessor :dice
    attr_accessor :value

    protected :dice, :value
    
    def initialize
      @dice = []
    end
    
    def add_die(die)
      @dice << die
    end
    
    def throw_dice
      @value = []
      @dice.each do |die|
        @value << die.throw_die
      end
      @value.inject(:+)
    end
        
    def all_die_values_the_same?
      @value.uniq.count == 1
    end
  end
end

# double = true unless die.faces.sample.value.to_int == score && @dice.count == 2