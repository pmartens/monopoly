require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "Monopoly::Space::Utility - " do

  before do
    players = []
    (1..3).each do |i|
      players << Monopoly::Player.new("player#{i}")
    end
    settings = Monopoly::Settings.new(players)
    @monopoly = Monopoly::Monopoly.new(settings)
  end

  it "1. When player2 lands on an utility space the player must pay 4 times the throw value." do
    @monopoly.settings.players[0].reset
    @monopoly.settings.players[1].reset
    @monopoly.settings.players[0].receive_money 10
    @monopoly.settings.players[1].receive_money 8
    propertygroup = Monopoly::Space::Property::PropertyGroup.new("Test")
    utility = Monopoly::Space::Utility.new(@monopoly, propertygroup, "utility1")
    utility.land_action
    allow(@monopoly).to receive(:active_player) {@monopoly.settings.players[1]}
    dice = double("dice")
    allow(dice).to receive(:value) {2}
    allow(@monopoly.settings).to receive(:dice).and_return(dice)
    utility.land_action
    @monopoly.settings.players[1].money.should eq(0)
  end

  it "2. When owner lands on his own utility space, he pays no interest." do
    @monopoly.settings.players[0].reset
    @monopoly.settings.players[0].receive_money 10
    propertygroup = Monopoly::Space::Property::PropertyGroup.new("Test")
    utility = Monopoly::Space::Utility.new(@monopoly, propertygroup, "utility1")
    utility.land_action
    dice = double("dice")
    allow(dice).to receive(:value) {2}
    allow(@monopoly.settings).to receive(:dice).and_return(dice)
    utility.land_action
    @monopoly.settings.players[0].money.should eq(0)
  end

  it "3. When player2 lands on utility space and owner is in use of all utility spaces. The player must pay 10 times the throw value." do
    @monopoly.settings.players[0].reset
    @monopoly.settings.players[1].reset
    @monopoly.settings.players[0].receive_money 20
    @monopoly.settings.players[1].receive_money 20
    properties = Monopoly::Space::Property::PropertyGroup.new("test")
    utility1 = Monopoly::Space::Utility.new(@monopoly, properties, "utility1")
    utility2 = Monopoly::Space::Utility.new(@monopoly, properties, "utility2")
    properties.add_property(utility1)
    properties.add_property(utility2)
    utility1.land_action
    utility2.land_action
    allow(@monopoly).to receive(:active_player) {@monopoly.settings.players[1]}
    dice = double("dice")
    allow(dice).to receive(:value) {2}
    allow(@monopoly.settings).to receive(:dice).and_return(dice)
    utility1.land_action
    @monopoly.settings.players[1].money.should eq(0)
  end

end