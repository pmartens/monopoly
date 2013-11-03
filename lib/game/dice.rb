module Game
  class Dice
  
    attr_accessor :dice
    attr_accessor :value

    protected :dice, :value
    
    def throw_dice
      @value = []
      @dice.each do |die|
        @value << die.throw_dice
      end
      @value.sum
    end
        
    def all_die_values_the_same?
      @value.uniq.nil?
    end
  end
end

# double = true unless die.faces.sample.value.to_int == score && @dice.count == 2