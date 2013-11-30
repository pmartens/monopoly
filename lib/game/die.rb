module Game
  class Die

    attr_reader :value

    def initialize
      @values = []
      @value = 0
    end

    def add_values(values)
      values.each do |value|
        @values << value
      end
    end

    def throw_die
      @value = @values.sample.to_int
      @value
    end

  end
end