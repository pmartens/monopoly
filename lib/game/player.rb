module Game
  class Player

    attr_reader :name
    attr_accessor :position

    def initialize(name)
      raise "Player name empty!" unless !name.empty?
      @name = name
      reset
    end

    def reset
      @position = 0
    end

  end
end