#require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

# describe "Phase 1 and 2: Game Framework - Die" do
#   it "Gives a throw of a die the correct value" do
#     die = Game::Die.new
#     die.add_value(1)
#     die.throw_die.should eq(1)
#     die = Game::Die.new
#     die.add_value(0)
#     die.throw_die.should eq(0)
#     die = Game::Die.new
#     die.add_value(-1)
#     die.throw_die.should eq(-1)    
#   end
# end
# 
# describe "Phase 1 and 2: Game Framework - TraditionalDie" do
#   it "Gives a value between 1 and 6" do
#     die = Game::TraditionalDie.new
#     die.throw_die.should be_between(1, 6)
#   end
# end
# 
# describe "Phase 1 and 2: Game Framework - Dice" do
#   it "Give a throw of a die with the correct value" do
#     die = Game::Die.new
#     die.add_value(1)
#     dice = Game::Dice.new
#     dice.add_die(die)
#     dice.throw_dice.should eq(1)
#   end
#   it "After a throw detect all values are the same" do
#     die = Game::Die.new
#     die.add_value(1)
#     dice = Game::Dice.new
#     dice.add_die(die)
#     dice.add_die(die)
#     dice.throw_dice.should eq(2)
#     dice.all_die_values_the_same?.should be_true
#   end
#   it "After a throw detect all values are NOT the same" do
#     die1 = Game::Die.new
#     die1.add_value(1)
#     die2 = Game::Die.new
#     die2.add_value(2)
#     dice = Game::Dice.new
#     dice.add_die(die1)
#     dice.add_die(die2)
#     dice.throw_dice.should eq(3)
#     dice.all_die_values_the_same?.should be_false
#   end
# end
# 
# describe "Phase 1 and 2: Game Framework - DuoTraditionalDice" do
#   it "Should a throw of dice gives a value between 2 and 12?" do
#     dice = Game::DuoTraditionalDice.new
#     dice.throw_dice.should be_between(2, 12)
#   end
# end
# 
# describe "Phase 1 and 2: Game Framework - Player" do
#   it "Can create player?" do
#     player = Game::Player.new("player1")
#     player.name.should eq("player1")
#   end
#   it "Player receives money" do
#     player = Game::Player.new("player1")
#     player.receive_money(1)
#     player.money.should eq(1)
#   end
#   it "Player pays money" do
#     player = Game::Player.new("player1")
#     player.receive_money(1)
#     player.pay_money(1)
#     player.money.should eq(0)
#   end
#   it "Change player position" do
#     player = Game::Player.new("player1")
#     player.position = 1
#     player.position.should eq(1)
#   end
# end  
# 
# describe "Phase 1 and 2: Game Framework - Space" do
#   it "Create space" do
#     space = Game::Space.new("Test")
#     space.name.should eq("Test")
#   end
#   
#   it "Default space has no land action" do
#     space = Game::Space.new("Test")
#     space.land_action.should be_nil
#   end
#   
#   it "Default space has no pass action" do
#     space = Game::Space.new("Test")
#     space.pass_action.should be_nil
#   end
# end
# 
# describe "Phase 1 and 2: Game Framework - Gameboard" do
#   it "Create gameboard" do
#     gameboard = Game::GameBoard.new
#     gameboard.space(1).should be_nil
#   end
# end
# 
# describe "Phase 1 and 2: Game Framework - Settings" do
#   it "Create game settings" do
#     players = []
#     (1..2).each do |i|
#       players << Game::Player.new("player#{i}")
#     end
#     settings = Game::Settings.new(players)
#     settings.should_not be_nil
#   end  
# end

describe "Phase 1 and 2: Game Framework - BoardGame" do
  # before do
  #   players = []
  #   (1..2).each do |i|
  #     players << Game::Player.new("player#{i}")
  #   end
  #   @settings = Game::Settings.new(players)
  # end
  # it "Create BoardGame" do
  #   boardgame = Game::BoardGame.new(@settings)
  #   boardgame.should_not be_nil
  # end
  it "Player can throw dice" do
    players = []
    players << Game::Player.new("player1")
    gameboard = Game::GameBoard.new
    gameboard.add_space(Game::Space.new)
    dice = Game::Dice.new
    dice.add_die(Game::TraditionalDie.new)
    settings = Game::Settings.new(players, gameboard, dice)
    boardgame = Game::BoardGame.new(settings)
    boardgame.throw_dice
  end

end

# MONOPOLY _________________________________________________________________________________________________________
describe "Phase 1 and 2: Game Framework - Pot" do
  it "Create pot" do
    pot = Monopoly::Pot.new
    pot.money.should eq(0)
  end
  it "Can add money to pot" do
    pot = Monopoly::Pot.new
    pot.money_in(1)
    pot.money.should eq(1)
    pot.money_in(0)
    pot.money.should eq(1)
    pot.money_in(-1)
    pot.money.should eq(1)
    pot.money_in(1)
    pot.money.should eq(2)
  end
  it "The pot can be emptied" do
    pot = Monopoly::Pot.new
    pot.money_in(1)
    pot.money_out.should eq(1)
    pot.money.should eq(0)
  end
end

describe "Phase 1 and 2: Game Framework - Settings" do
  it "Monopoly plays with minimum of two players" do
    players = []
    players << Game::Player.new("player1")
    expect { Monopoly::Settings.new(players) }.to raise_error("play with at least 2 players")
    players << Game::Player.new("player2")
    Monopoly::Settings.new(players).should_not be_nil
  end
  it "Monopoly plays with maximum of eight players" do
    players = []
    (1..8).each do |i|
      players << Game::Player.new("player#{i}")
    end
    Monopoly::Settings.new(players).should_not be_nil
    players << Game::Player.new("player9")
    expect { Monopoly::Settings.new(players) }.to raise_error("Play with up to 8 players")
  end
  it "Monopoly start fund off 1500" do
    players = []
    (1..2).each do |i|
      players << Game::Player.new("player#{i}")
    end
    settings = Monopoly::Settings.new(players)
    settings.start_fund.should eq(1500)
  end
end

describe "Phase 1 and 2: Game Framework - MonopolyBoard" do
  # nothing to test
end

describe "Phase 1 and 2: Game Framework - Monopoly" do
  before do
    players = []
    (1..2).each do |i|
      players << Game::Player.new("player#{i}")
    end
    @settings = Monopoly::Settings.new(players)
  end
  it "Create monopoly" do
    Monopoly::Monopoly.new(@settings).should_not be_nil
  end
end

describe "Phase 1 and 2: Game Framework - Space" do  
  it "Create Monopoly spaces" do
    space = Monopoly::Space.new("test")
    space.name.should eq("test")  
  end    
end

describe "Phase 1 and 2: Game Framework - StartSpace" do
  it "Create Monopoly startspace" do
     start = Monopoly::StartSpace.new
     start.name.should eq("start")
  end
  it "Should has passing value of $100" do
     player = Game::Player.new("player1")
     start = Monopoly::StartSpace.new
     start.pass_action(player)
     player.money.should eq(100)  
  end
  it "Should has landing value of $200" do
     player = Game::Player.new("player1")
     start = Monopoly::StartSpace.new
     start.land_action(player)
     player.money.should eq(200)
  end
end

describe "Phase 1 and 2: Game Framework - FreeParkingSpace" do  
  it "Create Monopoly FreeParking" do
    freeparking = Monopoly::FreeParkingSpace.new
    freeparking.name.should eq("freeparking")
  end
  it "Should have no passing value" do
    player = Game::Player.new("player1")
    pot = Monopoly::Pot.new
    freeparking = Monopoly::FreeParkingSpace.new
    freeparking.pass_action(player, pot)
    player.money.should eq(0) 
  end
  it "Should have landing value and gives pot money" do
    player = Game::Player.new("player1")
    pot = Monopoly::Pot.new
    pot.money_in(1)
    freeparking = Monopoly::FreeParkingSpace.new
    freeparking.land_action(player, pot)
    player.money.should eq(1)
    pot.money.should eq(0)
  end
end

describe "Phase 1 and 2: Game Framework - IncomeTaxSpace" do
  it "Create Monopoly IncomeTaxSpace" do
    incometaxspace = Monopoly::IncomeTaxSpace.new
    incometaxspace.name.should eq("incometax")
  end
  it "Should not have passing value" do
    player = Game::Player.new("player1")
    player.money = 1
    pot = Monopoly::Pot.new
    incometaxspace = Monopoly::IncomeTaxSpace.new
    incometaxspace.pass_action(player, pot)
    player.money.should eq(1)    
  end
  it "Should have landing value and pays $200" do
    player = Game::Player.new("player1")
    player.money = 200
    pot = Monopoly::Pot.new
    incometaxspace = Monopoly::IncomeTaxSpace.new
    incometaxspace.land_action(player, pot)
    player.money.should eq(0)    
    pot.money.should eq(200)
  end  
end

describe "Phase 1 and 2: Game Framework - LuxuryTaxSpace" do
  it "Create Monopoly LuxuryTaxSpace" do
    luxurytax = Monopoly::LuxuryTaxSpace.new
    luxurytax.name.should eq("luxurytax")
  end
  it "Should not have passing value" do
    player = Game::Player.new("player1")
    player.money = 1
    pot = Monopoly::Pot.new
    luxurytax = Monopoly::LuxuryTaxSpace.new
    luxurytax.pass_action(player, pot)
    player.money.should eq(1)    
  end
  it "Should have landing value and pays $100" do
    player = Game::Player.new("player1")
    player.money = 100
    pot = Monopoly::Pot.new
    luxurytax = Monopoly::LuxuryTaxSpace.new
    luxurytax.land_action(player, pot)
    player.money.should eq(0)    
    pot.money.should eq(100)
  end
end

describe "Phase 1 and 2: Game Framework - Monopoly deel 2" do

  it "Create monopoly" do
    players = []
    players << Game::Player.new("player1")
    players << Game::Player.new("player2")
    settings = Monopoly::Settings.new(players)
    monopoly = Monopoly::Monopoly.new(settings)
    monopoly.throw_dice
  end
end




  