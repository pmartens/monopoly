module Game
  class DuoTraditionalDice < Dice
    
    def initialize
      add_die(Game::TraditionalDie.new)
      add_die(Game::TraditionalDie.new)
    end  
    
    def double?
      all_die_values_the_same?
    end
    
  end
end