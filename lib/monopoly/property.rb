module Monopoly
  class Property < GameSpace

    attr_reader :owner

    def initialize(monopoly, properties, name, sale_price, interest)
      @owner = nil
      @properties = properties
      @sale_price = sale_price
      @interest = interest
      super(monopoly, name)
    end

    def land_action
      return if @boardgame.active_player == @owner
      if @owner.nil?
        @boardgame.active_player.pay_money(@sale_price)
        @owner = @boardgame.active_player unless @boardgame.active_player.bankrupt?
      else
        @owner.receive_money(@boardgame.active_player.pay_money(interest))
      end
    end

    :protected

    attr_reader :sale_price

    def interest
      @interest
    end

  end
end