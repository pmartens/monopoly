module Monopoly
  class Property < Game::Space

    attr_reader :owner
    attr_reader :sale_price

    def initialize(monopoly, properties, name, sale_price, interest)
      @owner = nil
      @properties = properties
      @sale_price = sale_price
      @interest = interest
      super(monopoly, name)
    end

    def land_action(player)
      return if player == @owner
      if @owner.nil?
        player.pay_money(@sale_price)
        @owner = player unless player.bankrupt?
      else
        @owner.receive_money(player.pay_money(interest))
      end
    end

    :protected

    def interest
      @interest
    end

  end
end