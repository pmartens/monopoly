module Monopoly
  class PropertyWithAdditionalRent < PropertyDecorator

    def_delegators :@component, :owner, :land_action, :sale_price

    def initialize(component, additionalrent)
      @component = component
      @additionalrent = additionalrent
      super(component)
    end

    def interest
      if !owner.nil? && !@additionalrent.receiver.nil? && owner == @additionalrent.receiver && @component.interest > 0
        (@component.interest + (( @component.interest / 100 ) * @additionalrent.get_rent_percentage())).round(2)
      else
        @component.interest
      end
    end

  end
end