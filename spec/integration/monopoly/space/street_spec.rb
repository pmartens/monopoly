require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "Monopoly::Space::Street - " do

  before do
    players = []
    (1..3).each do |i|
      players << Monopoly::Player.new("player#{i}")
    end
    settings = Monopoly::Settings.new(players)
    @monopoly = Monopoly::Monopoly.new(settings)
  end

  it "1. When a player lands on a street where the owner owns 2 streets the player must pay double interest." do
    propertygroup = Monopoly::Space::Property::PropertyGroup.new("Test")
    @monopoly.settings.players[0].reset
    @monopoly.settings.players[1].reset
    @monopoly.settings.players[1].receive_money(2)
    street1 = Monopoly::Space::Street.new(@monopoly, propertygroup, "test1", 0, 1)
    street2 = Monopoly::Space::Street.new(@monopoly, propertygroup, "test2", 0, 1)
    propertygroup.add_property(street1)
    propertygroup.add_property(street2)
    street1.land_action
    street2.land_action
    allow(@monopoly).to receive(:active_player) {@monopoly.settings.players[1]}
    street1.land_action
    @monopoly.settings.players[1].money.should eq(0)
    @monopoly.settings.players[0].money.should eq(2)
  end

end