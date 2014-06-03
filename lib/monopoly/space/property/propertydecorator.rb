module Monopoly
  class PropertyDecorator
    extend Forwardable

    def initialize(component)
      @component = component
    end

  end
end