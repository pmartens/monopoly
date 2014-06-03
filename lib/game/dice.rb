module Game
  class Dice

    def initialize
      @dice = []
      @value = 0
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

    def all_values_equal?
      @value.uniq.count == 1
    end

    def value
      return 0 if @value.empty?
      @value.inject(:+)
    end
  end
end