module Monopoly
  class Pot

    attr_reader :money

    def initialize
      @money = 0
    end

    def pay_out
      m = @money
      @money = 0
      m
    end

    def money_in(amount)
      @money += amount unless amount < 0
    end

  end
end