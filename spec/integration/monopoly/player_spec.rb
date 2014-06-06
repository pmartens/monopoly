require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Monopoly::Player ->" do

    before do
      @player = Monopoly::Player.new("player1")
    end

    it "When playersettings resets the player is has 0$." do
      @player.receive_money 1
      @player.reset
      @player.money.should eq(0)
    end

    it "When player has 0$ and receives 1$ the player has 1$ dollar." do
      @player.receive_money 1
      @player.money.should eq(1)
    end

    it "When player has 0$ and receives 0$, the payer has 0$ dollar." do
      @player.reset
      @player.receive_money 0
      @player.money.should eq(0)
    end

    it "When player has 0$ and receives -1$, the payer has 0$ dollar." do
      @player.reset
      @player.receive_money -1
      @player.money.should eq(0)
    end

    it "When player has 1$ and must pay 1$ the player has 0$. " do
      @player.receive_money 1
      @player.pay_money 1
      @player.money.should eq(0)
    end

    it "When player has 1$ and must pay 0$ the player has 1$. " do
      @player.receive_money 1
      @player.pay_money 0
      @player.money.should eq(1)
    end

    it "When player has 1$ and must pay -1$ the player has 1$. " do
      @player.receive_money 1
      @player.pay_money -1
      @player.money.should eq(1)
    end

    it "When player has 0$ and must pay 1$, the player is bankrupt." do
      @player.pay_money 1
      @player.bankrupt?.should be_true
    end

    it "When player ha 0$, the player is nit bankrupt." do
      @player.reset
      @player.bankrupt?.should be_false
    end
end
