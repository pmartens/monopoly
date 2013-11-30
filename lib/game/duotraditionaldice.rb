module Game
  class DuoTraditionalDice < Dice

    def initialize
      super
      add_die(Game::TraditionalDie.new)
      add_die(Game::TraditionalDie.new)
    end

    def double?
      all_values_equal?
    end

  end
end