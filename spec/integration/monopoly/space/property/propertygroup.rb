require File.expand_path(File.dirname(__FILE__) + '/../../../../spec_helper')

describe "Monopoly::Space::Property::PropertyGroup - " do

  before do
    players = []
    (1..3).each do |i|
      players << Monopoly::Player.new("player#{i}")
    end
    settings = Monopoly::Settings.new(players)
    @monopoly = Monopoly::Monopoly.new(settings)
    @monopoly.settings.players[0].reset
  end

  # owns_count

  it "1. When a player owns 0 properties in a propertygroup.rb the own count is 0." do
    propertygroup = Monopoly::Space::Property::PropertyGroup.new("test")
    propertygroup.owns_count @monopoly.settings.players[0].money.should eq(0)
  end

  it "2. When a player owns 1 property in a propertygroup.rb off 1 the own count is 1." do
    property = double("property")
    allow(property).to receive(:owner) {@monopoly.settings.players[0]}
    propertygroup = Monopoly::Space::Property::PropertyGroup.new("test")
    propertygroup.add_property(property)
    propertygroup.owns_count(@monopoly.settings.players[0]).should eq(1)
  end

  it "3. When a player owns 1 property in a propertygroup.rb off 3 the own count is 1." do
    property1 = double("property1")
    allow(property1).to receive(:owner) {@monopoly.settings.players[0]}
    property2 = double("property")
    allow(property2).to receive(:owner) {nil}
    propertygroup = Monopoly::Space::Property::PropertyGroup.new("test")
    propertygroup.add_property(property1)
    propertygroup.add_property(property2)
    propertygroup.add_property(property2)
    propertygroup.owns_count(@monopoly.settings.players[0]).should eq(1)
  end

  it "4. When a player owns 2 property in a propertygroup.rb off 3 the own count is 2." do
    property1 = double("property1")
    allow(property1).to receive(:owner) {@monopoly.settings.players[0]}
    property2 = double("property")
    allow(property2).to receive(:owner) {nil}
    propertygroup = Monopoly::Space::Property::PropertyGroup.new("test")
    propertygroup.add_property(property1)
    propertygroup.add_property(property1)
    propertygroup.add_property(property2)
    propertygroup.owns_count(@monopoly.settings.players[0]).should eq(2)
  end

  it "5. When a player owns 3 properties in a propertygroup.rb the own count is 3." do
    property1 = double("property1")
    allow(property1).to receive(:owner) {@monopoly.settings.players[0]}
    propertygroup = Monopoly::Space::Property::PropertyGroup.new("test")
    propertygroup.add_property(property1)
    propertygroup.add_property(property1)
    propertygroup.add_property(property1)
    propertygroup.owns_count(@monopoly.settings.players[0]).should eq(3)
  end

  # owns_all

  it "6. When a player owns 1 property in a propertygroup.rb, he doesn't own all properties in de group." do
    property1 = double("property1")
    allow(property1).to receive(:owner) {@monopoly.settings.players[0]}
    property2 = double("property")
    allow(property2).to receive(:owner) {nil}
    propertygroup = Monopoly::Space::Property::PropertyGroup.new("test")
    propertygroup.add_property(property1)
    propertygroup.add_property(property2)
    propertygroup.add_property(property2)
    propertygroup.owns_all(@monopoly.settings.players[0]).should be_false
  end

  it "7. When a player owns all properties in a propertygroup.rb, he doesn't own all properties in de group." do
    property1 = double("property1")
    allow(property1).to receive(:owner) {@monopoly.settings.players[0]}
    propertygroup = Monopoly::Space::Property::PropertyGroup.new("test")
    propertygroup.add_property(property1)
    propertygroup.add_property(property1)
    propertygroup.add_property(property1)
    propertygroup.owns_all(@monopoly.settings.players[0]).should be_true
  end
end

