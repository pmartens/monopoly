module Monopoly
  class Street < Property

    private:

    def interest
      @properties.owns_all(@owner) ? @interest * 2 : @interest
    end

  end
end