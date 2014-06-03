require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Monopoly::Pot - " do

  # money_in
  it "1. When add 1$ to an empty pot there is 1$ in the pot." do
    pot = Monopoly::Pot.new
    pot.money_in(1)
    pot.money.should eq(1)
  end

  it "2. When add -1$ to an empty pot there is 0$ in the pot." do
    pot = Monopoly::Pot.new
    pot.money_in(-1)
    pot.money.should eq(0)
  end

  it "3. When add 0$ to an empty pot there is 0$ in the pot." do
    pot = Monopoly::Pot.new
    pot.money_in(0)
    pot.money.should eq(0)
  end

  it "4. When add two times 1$ to an empty pot there is 2$ in the pot." do
    pot = Monopoly::Pot.new
    pot.money_in(1)
    pot.money_in(1)
    pot.money.should eq(2)
  end

  # pay_out
  it "5. When the pot with 1$ is emptied there is 0$ in the pot." do
    pot = Monopoly::Pot.new
    pot.money_in(1)
    pot.pay_out
    pot.money.should eq(0)
  end

end