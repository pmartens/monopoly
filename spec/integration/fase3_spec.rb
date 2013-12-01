#require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Phase 3: Properties - Player" do
  it "wanneer speler minder dan $0 heeft dan is deze bankroet" do
    player = Monopoly::Player.new("player1")
    player.pay_money(1)
    player.bankrupt?.should be_true
  end
end

describe "Phase 3: Properties - Monopoly" do
  before do
    players = []
    player1 = Monopoly::Player.new("player1")
    player1.pay_money(1501)
    players << player1
    player2 = Monopoly::Player.new("player2")
    players << player2
    settings = Monopoly::Settings.new(players)
    @monopoly = Monopoly::Monopoly.new(settings)
  end
  it "1: De laatste nog actieve speler moet de winnaar zijn van het spel" do
    @monopoly.winner?.should be_true
  end
  it "2: Het Monopoly spel moet afgelopen zijn wanneer er een winner bekend is." do
    expect { @monopoly.throw_dice }.to raise_error("game played")
  end
end

describe "Phase 3: Properties - Monopoly Property : " do

  before do
    players = []
    @player1 = Monopoly::Player.new("player1")
    @player2 = Monopoly::Player.new("player2")
    players << @player1
    players << @player2
    settings = Monopoly::Settings.new(players)
    @monopoly = Monopoly::Monopoly.new(settings)
  end

  it "1: Wanneer de eerste speler op het vastgoed vakje land dan is hij/zij automatisch eigenaar." do
    properties = double("properties")
    property = Monopoly::Property.new(@monopoly, properties, "test", 0, 0)
    property.land_action(@player1)
    property.owner.should eq(@player1)
  end
  it "2: Wanneer de eerste speler op het vastgoed vakje land dan moet hij/zij de aankoopprijs betalen." do
    properties = double("properties")
    @player1.receive_money(1)
    property = Monopoly::Property.new(@monopoly, properties, "test", 1, 0)
    property.land_action(@player1)
    property.owner.should eq(@player1)
  end
  it "3: Wanneer de eerste speler op het vastgoed vakje land dan wordt het aankoop bedrag afgeschreven van zijn saldo." do
    properties = double("properties")
    @player1.reset
    @player1.receive_money(1)
    property = Monopoly::Property.new(@monopoly, properties, "test", 1, 0)
    property.land_action(@player1)
    @player1.money.should eq(0)
  end
  it "4: Wanneer de eerste speler op het vastgoed vakje land en geen voldoende saldo heeft dan kan hij/zij het vastgoed niet kopen." do
    properties = double("properties")
    @player1.reset
    @player1.pay_money(1)
    property = Monopoly::Property.new(@monopoly, properties, "test", 1, 0)
    property.land_action(@player1)
    property.owner.should be_nil
  end
  it "5: Wanneer een tweede speler op het vastgoed vakje land dan moet hij/zij rente betalen." do
    properties = Monopoly::PropertyGroup.new("Test")
    @player2.reset
    @player2.receive_money(1)
    property = Monopoly::Property.new(@monopoly, properties, "test", 0, 1)
    property.land_action(@player1)
    property.land_action(@player2)
    @player2.money.should eq(0)
  end
  it "6: Wanneer een tweede speler op het vastgoed vakje land dan moet hij/zij rente betalen aan de eigenaar." do
    properties = Monopoly::PropertyGroup.new("Test")
    @player2.reset
    @player2.receive_money(1)
    property = Monopoly::Property.new(@monopoly, properties, "test", 0, 1)
    property.land_action(@player1)
    property.land_action(@player2)
    @player1.money.should eq(1501)
  end
  it "7: Wanneer een tweede speler op het vastgoed vakje land waarvan de eigenaar ook in het bezit is van al het ander gelijkwaardig vastgoed dan moet dubbele rente worden betaald." do
    properties = Monopoly::PropertyGroup.new("Test")
    @player1.reset
    @player2.reset
    @player2.receive_money(2)
    property1 = Monopoly::Property.new(@monopoly, properties, "test1", 0, 1)
    property2 = Monopoly::Property.new(@monopoly, properties, "test2", 0, 1)
    properties.add_property(property1)
    properties.add_property(property2)
    property1.land_action(@player1)
    property2.land_action(@player1)
    property1.land_action(@player2)
    @player2.money.should eq(0)
  end
  it "8: Wanneer een tweede speler op het vastgoed vakje land waarvan de eigenaar ook in het bezit is van al het ander gelijkwaardig vastgoed dan moet de eigenaar dubbele rente ontvangen." do
    properties = Monopoly::PropertyGroup.new("Test")
    @player1.reset
    @player2.reset
    @player2.receive_money(2)
    property1 = Monopoly::Property.new(@monopoly, properties, "test1", 0, 1)
    property2 = Monopoly::Property.new(@monopoly, properties, "test2", 0, 1)
    properties.add_property(property1)
    properties.add_property(property2)
    property1.land_action(@player1)
    property2.land_action(@player1)
    property1.land_action(@player2)
    @player1.money.should eq(2)
  end
end

describe "Phase 3: Properties - Monopoly PropertyGroup" do

  it "1: Een stad zou straten als vastgoed moeten hebben." do
    properties = Monopoly::PropertyGroup.new("test")
    property = double("property")
    allow(property).to receive(:name) { "property" }
    properties.add_property(property)
    properties.properties[0].name.should eq("property")
  end
  it "2: Spelers moeten weten hoeveel vastgoed er binnen een vastgoed verzameling aanwezig is." do
    properties = Monopoly::PropertyGroup.new("test")
    property = double("property")
    properties.add_property(property)
    properties.add_property(property)
    properties.property_count.should eq(2)
  end
  it "3: Een speler moet kunnen weten hoeveel vastgoed hij bezit." do
    properties = Monopoly::PropertyGroup.new("test")
    property = double("property")
    player = double("player")
    allow(property).to receive(:owner).and_return(player)
    properties.add_property(property)
    properties.add_property(property)
    properties.owns_count(player).should eq(2)
  end
  it "4: Een speler moet eigenaar kunnen zijn van al het vastgoed" do
    properties = Monopoly::PropertyGroup.new("test")
    property = double("property")
    player = double("player")
    allow(property).to receive(:owner).and_return(player)
    properties.add_property(property)
    properties.add_property(property)
    properties.owns_all(player).should be_true
  end
  it "5: Een speler moet eigenaar kunnen zijn van enkele vastgoed" do
    properties = Monopoly::PropertyGroup.new("test")
    property1 = double("property1")
    property2 = double("property2")
    player1 = double("player1")
    player2 = double("player2")
    allow(property1).to receive(:owner).and_return(player1)
    allow(property2).to receive(:owner).and_return(player2)
    properties.add_property(property1)
    properties.add_property(property2)
    properties.owns_all(player1).should be_false
  end
end

describe "Phase 3: Properties - Monopoly Street" do

  before do
    players = []
    @player1 = Monopoly::Player.new("player1")
    @player2 = Monopoly::Player.new("player2")
    players << @player1
    players << @player2
    settings = Monopoly::Settings.new(players)
    @monopoly = Monopoly::Monopoly.new(settings)
  end

  it "Er kan een vastgoed vakje straat worden aangemaakt." do
    properties = double("properties")
    street = Monopoly::Space::Street.new(@monopoly, properties, "street1", 0, 0)
    street.should_not be_nil
  end
end

describe "Phase 3: Properties - Monopoly Utility" do

  before do
    players = []
    @player1 = Monopoly::Player.new("player1")
    @player2 = Monopoly::Player.new("player2")
    players << @player1
    players << @player2
    settings = Monopoly::Settings.new(players)
    @monopoly = Monopoly::Monopoly.new(settings)
  end

  it "1: Er kan een vastgoed vakje nutsbedrijf worden aangemaakt." do
    properties = double("properties")
    utility = Monopoly::Space::Utility.new(@monopoly, properties, "utility1")
    utility.should_not be_nil
  end
  it "2: Wanneer een tweede speler op een nutsbedrijf vakje land dan moet hij/zij viermaal de ogen van een worp aan rente betalen." do
    @player1.reset
    @player1.receive_money(10)
    @player2.reset
    @player2.receive_money(8)
    properties = Monopoly::PropertyGroup.new("test")
    utility1 = Monopoly::Space::Utility.new(@monopoly, properties, "utility1")
    utility2 = Monopoly::Space::Utility.new(@monopoly, properties, "utility2")
    properties.add_property(utility1)
    properties.add_property(utility2)
    dice = double("dice")
    allow(dice).to receive(:value) {2}
    allow(@monopoly.settings).to receive(:dice).and_return(dice)
    utility1.land_action(@player1)
    utility1.land_action(@player2)
    @player2.money.should eq(0)
  end
  it "3: Wanneer een tweede speler op een nutsbedrijf vakje land en de eigenaar is in het bezit is van meerdere nutsbedrijven dan moet als rente, tienmaal de ogen van een worp als waarde worden betaald." do
    @player1.reset
    @player1.receive_money(20)
    @player2.reset
    @player2.receive_money(20)
    properties = Monopoly::PropertyGroup.new("test")
    utility1 = Monopoly::Space::Utility.new(@monopoly, properties, "utility1")
    utility2 = Monopoly::Space::Utility.new(@monopoly, properties, "utility2")
    properties.add_property(utility1)
    properties.add_property(utility2)
    dice = double("dice")
    allow(dice).to receive(:value) {2}
    allow(@monopoly.settings).to receive(:dice).and_return(dice)
    utility1.land_action(@player1)
    utility2.land_action(@player1)
    utility1.land_action(@player2)
    @player2.money.should eq(0)
  end
end

describe "Phase 3: Properties - Monopoly Station" do

  before do
    players = []
    @player1 = Monopoly::Player.new("player1")
    @player2 = Monopoly::Player.new("player2")
    players << @player1
    players << @player2
    settings = Monopoly::Settings.new(players)
    @monopoly = Monopoly::Monopoly.new(settings)
  end

  it "1: Er kan een vastgoed vakje station worden aangemaakt." do
    properties = double("properties")
    utility = Monopoly::Space::Station.new(@monopoly, properties, "station zuid")
    utility.should_not be_nil
  end
  it "2: Wanneer een tweede speler op een station vakje land en de eigenaar is in het bezit van 2 stations dan moet de dubble rente worden betaald." do
    @player1.reset
    @player1.receive_money(20)
    @player2.reset
    @player2.receive_money(4)
    properties = Monopoly::PropertyGroup.new("test")
    station1 = Monopoly::Space::Station.new(@monopoly, properties, "station1")
    station2 = Monopoly::Space::Station.new(@monopoly, properties, "station2")
    properties.add_property(station1)
    properties.add_property(station2)
    station1.land_action(@player1)
    station2.land_action(@player1)
    station1.land_action(@player2)
    @player2.money.should eq(0)
  end
  it "3: Wanneer een tweede speler op een station vakje land en de eigenaar is in het bezit van 3 stations dan moet 3 maal de rente worden betaald." do
    @player1.reset
    @player1.receive_money(30)
    @player2.reset
    @player2.receive_money(6)
    properties = Monopoly::PropertyGroup.new("test")
    station1 = Monopoly::Space::Station.new(@monopoly, properties, "station1")
    station2 = Monopoly::Space::Station.new(@monopoly, properties, "station2")
    station3 = Monopoly::Space::Station.new(@monopoly, properties, "station3")
    properties.add_property(station1)
    properties.add_property(station2)
    properties.add_property(station3)
    station1.land_action(@player1)
    station2.land_action(@player1)
    station3.land_action(@player1)
    station1.land_action(@player2)
    @player2.money.should eq(0)
  end
end