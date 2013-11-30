#require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Phase 3: Properties - Player" do
  it "wanneer speler minder dan $0 heeft dan is deze bankroet" do
    player = Monopoly::Player.new("player1")
    player.pay_money(1)
    player.bankrupt?.should be_true
  end
end

describe "Phase 3: Properties - Monopoly Property : " do
  # Wanneer de eerste speler op het vastgoed land dan koopt de speler deze automatisch
  it "Wanneer de eerste speler op het vastgoed vakje land dan is hij/zij automatisch eigenaar." do
    settings = double("settings")
    properties = double("properties")
    player = Monopoly::Player.new("player1")
    property = Monopoly::Property.new(settings, properties, "test")
    property.land_action(player)
    property.owner.should eq(player)
  end
  it "Wanneer de eerste speler op het vastgoed vakje land dan moet hij/zij de aankoopprijs betalen." do
    settings = double("settings")
    properties = double("properties")
    player = Monopoly::Player.new("player1")
    player.receive_money(1)
    property = Monopoly::Property.new(settings, properties, "test")
    allow(property).to receive(:sale_price) { 1 }
    property.land_action(player)
    property.owner.should eq(player)
  end
  it "Wanneer de eerste speler op het vastgoed vakje land dan wordt het aankoop bedrag afgeschreven van zijn saldo." do
    settings = double("settings")
    properties = double("properties")
    player = Monopoly::Player.new("player1")
    player.receive_money(1)
    property = Monopoly::Property.new(settings, properties, "test")
    allow(property).to receive(:sale_price) { 1 }
    property.land_action(player)
    player.money.should eq(0)
  end
  it "Wanneer de eerste speler op het vastgoed vakje land en geen voldoende saldo heeft dan kan hij/zij het vastgoed niet kopen." do
    settings = double("settings")
    properties = double("properties")
    player = Monopoly::Player.new("player1")
    property = Monopoly::Property.new(settings, properties, "test")
    allow(property).to receive(:sale_price) { 1 }
    property.land_action(player)
    property.owner.should be_nil
  end
  it "Wanneer een tweede speler op het vastgoed vakje land dan moet hij/zij rente betalen." do
    settings = double("settings")
    properties = Monopoly::Properties.new(settings)
    player1 = Monopoly::Player.new("player1")
    player2 = Monopoly::Player.new("player2")
    player2.receive_money(1)
    property = Monopoly::Property.new(settings, properties, "test")
    allow(property).to receive(:interest) { 1 }
    property.land_action(player1)
    property.land_action(player2)
    player2.money.should eq(0)
  end
  it "Wanneer een tweede speler op het vastgoed vakje land dan moet hij/zij rente betalen aan de eigenaar." do
    settings = double("settings")
    properties = Monopoly::Properties.new(settings)
    player1 = Monopoly::Player.new("player1")
    player2 = Monopoly::Player.new("player2")
    player2.receive_money(1)
    property = Monopoly::Property.new(settings, properties, "test")
    allow(property).to receive(:interest) { 1 }
    property.land_action(player1)
    property.land_action(player2)
    player1.money.should eq(1)
  end
  it "Wanneer een tweede speler op het vastgoed vakje land waarvan de eigenaar ook in het bezit is van al het ander gelijkwaardig vastgoed dan moet dubbele rente worden betaald." do
    settings = double("settings")
    properties = Monopoly::Properties.new(settings)
    player1 = Monopoly::Player.new("player1")
    player2 = Monopoly::Player.new("player2")

    property1 = Monopoly::Property.new(settings, properties, "test1")
    property1.land_action(player1)

    properties.add_property(property1)
    properties.add_property(property1)

    player2.receive_money(2)
    property = Monopoly::Property.new(settings, properties, "test2")
    allow(property).to receive(:interest) { 1 }
    property.land_action(player1)
    property.land_action(player2)
    player2.money.should eq(0)
  end
  it "Wanneer een tweede speler op het vastgoed vakje land waarvan de eigenaar ook in het bezit is van al het ander gelijkwaardig vastgoed dan moet de eigenaar dubbele rente ontvangen." do
    settings = double("settings")
    properties = Monopoly::Properties.new(settings)
    player1 = Monopoly::Player.new("player1")
    player2 = Monopoly::Player.new("player2")

    property1 = Monopoly::Property.new(settings, properties, "test1")
    property1.land_action(player1)

    properties.add_property(property1)
    properties.add_property(property1)

    player2.receive_money(2)
    property = Monopoly::Property.new(settings, properties, "test2")
    allow(property).to receive(:interest) { 1 }
    property.land_action(player1)
    property.land_action(player2)
    player1.money.should eq(2)
  end
end

describe "Phase 3: Properties - Monopoly Properties" do
  it "Een stad zou straten als vastgoed moeten hebben." do
    settings = double("settings")
    properties = Monopoly::Properties.new(settings)
    property = double("property")
    allow(property).to receive(:name) { "property" }
    properties.add_property(property)
    properties.properties[0].name.should eq("property")
  end
  it "Spelers moeten weten hoeveel vastgoed er binnen een vastgoed verzameling aanwezig is." do
    settings = double("settings")
    properties = Monopoly::Properties.new(settings)
    property = double("property")
    properties.add_property(property)
    properties.add_property(property)
    properties.property_count.should eq(2)
  end
  it "Een speler moet kunnen weten hoeveel vastgoed hij bezit." do
    settings = double("settings")
    properties = Monopoly::Properties.new(settings)
    property = double("property")
    player = double("player")
    allow(property).to receive(:owner).and_return(player)
    properties.add_property(property)
    properties.add_property(property)
    properties.owns_count(player).should eq(2)
  end
  it "Een speler moet eigenaar kunnen zijn van al het vastgoed" do
    settings = double("settings")
    properties = Monopoly::Properties.new(settings)
    property = double("property")
    player = double("player")
    allow(property).to receive(:owner).and_return(player)
    properties.add_property(property)
    properties.add_property(property)
    properties.owns_all(player).should be_true
  end
  it "Een speler moet eigenaar kunnen zijn van enkele vastgoed" do
    settings = double("settings")
    properties = Monopoly::Properties.new(settings)
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
  it "Er kan een vastgoed vakje straat worden aangemaakt." do
    settings = double("settings")
    properties = double("properties")
    street = Monopoly::Street.new(settings, properties, "street1")
    street.should_not be_nil
  end
end

describe "Phase 3: Properties - Monopoly Utility" do
  it "Er kan een vastgoed vakje nutsbedrijf worden aangemaakt." do
    settings = double("settings")
    properties = double("properties")
    utility = Monopoly::Utility.new(settings, properties, "utility1")
    utility.should_not be_nil
  end
  it "Wanneer een tweede speler op een nutsbedrijf vakje land dan moet hij/zij viermaal de ogen van een worp aan rente betalen." do
    dice = double("dice")
    allow(dice).to receive(:value) {2}
    settings = double("settings")
    allow(settings).to receive(:dice).and_return(dice)

    player1 = Monopoly::Player.new("player1")
    properties = Monopoly::Properties.new(settings)
    property1 = Monopoly::Property.new(settings, properties, "test1")
    property1.land_action(player1)
    properties.add_property(property1)
    property2 = Monopoly::Property.new(settings, properties, "test1")
    properties.add_property(property2)

    utility = Monopoly::Utility.new(settings, properties, "utility1")

    player2 = Monopoly::Player.new("player2")
    player2.receive_money(8)
    utility.land_action(player1)
    utility.land_action(player2)
    player2.money.should eq(0)
  end

  it "Wanneer een tweede speler op een nutsbedrijf vakje land en de eigenaar is in het bezit is van meerdere nutsbedrijven dan moet als rente, tienmaal de ogen van een worp als waarde worden betaald." do
    dice = double("dice")
    allow(dice).to receive(:value) {2}
    settings = double("settings")
    allow(settings).to receive(:dice).and_return(dice)

    player1 = Monopoly::Player.new("player1")
    properties = Monopoly::Properties.new(settings)
    property1 = Monopoly::Property.new(settings, properties, "test1")
    property1.land_action(player1)
    properties.add_property(property1)
    properties.add_property(property1)

    utility = Monopoly::Utility.new(settings, properties, "utility1")

    player2 = Monopoly::Player.new("player2")
    player2.receive_money(20)
    utility.land_action(player1)
    utility.land_action(player2)
    player2.money.should eq(0)
  end

end

describe "Phase 3: Properties - Monopoly Station" do
  it "Er kan een vastgoed vakje station worden aangemaakt." do
    settings = double("settings")
    properties = double("properties")
    utility = Monopoly::Station.new(settings, properties, "station zuid")
    utility.should_not be_nil
  end
  it "Wanneer een tweede speler op een station vakje land en de eigenaar is in het bezit van 2 stations dan moet de dubble rente worden betaald." do
  end
  it "Wanneer een tweede speler op een station vakje land en de eigenaar is in het bezit van 3 stations dan moet 3 maal de rente worden betaald." do
  end
end

describe "Phase 3: Properties - Monopoly Town" do
  before do
    settings = double("settings")
    @town = Monopoly::Town.new(settings, "Arnhem")
    property1 = double("property")
    allow(property1).to receive(:name) {"steenstraat"}
    property2 = double("property")
    allow(property2).to receive(:name) {"ketelstraat"}
    property3 = double("property")
    allow(property3).to receive(:name) {"velperplein"}
    @town.add_property(property1)
    @town.add_property(property2)
    @town.add_property(property3)
  end
  it "Steenstraat moet de eerste straat zijn van de verzameling Monopoly straten voor de stad Arnhem." do
    @town.properties[0].name.should eq("steenstraat")
  end
  it "Ketelstraat moet de tweede straat zijn van de verzameling Monopoly straten voor de stad Arnhem." do
    @town.properties[1].name.should eq("ketelstraat")
  end
  it "Velperplein mpet de derde straat zijn van de verzameling Monopoly straten voor de stad Arnhem." do
    @town.properties[2].name.should eq("velperplein")
  end
end

describe "Phase 3: Properties - Monopoly Towns" do
  before do
    settings = double("settings")
    @towns = Monopoly::Towns.new(settings)
  end
  it "Ons Dorp moet de eerste stad zijn van de verzameling Monopoly steden." do
    @towns.towns[0].name.should eq("Ons Dorp")
  end
  it "Arnhem moet de tweede stad zijn van de verzameling Monopoly steden." do
    @towns.towns[1].name.should eq("Arnhem")
  end
  it "Amsterdam moet de laatste stad zijn van de verzameling Monopoly steden." do
    @towns.towns[@towns.towns.count-1].name.should eq("Amsterdam")
  end
end

describe "Phase 3: Properties - Monopoly Utilities" do
  before do
    settings = double("settings")
    @utilities = Monopoly::Utilities.new(settings)
  end
  it "Elektriciteitsbedrijf moet het eerste nutsbedrijf zijn van de verzameling Monopoly nutsbedrijven." do
    @utilities.properties[0].name.should eq("electric utility")
  end
  it "Waterleiding moet het tweede nutsbedrijf zijn van de verzameling Monopoly nutsbedrijven." do
    @utilities.properties[1].name.should eq("water utility")
  end
end

describe "Phase 3: Properties - Monopoly Stations" do
  before do
    settings = double("settings")
    @stations = Monopoly::Stations.new(settings)
  end
  it "Station zuid moet het eerste station zijn van de verzameling Monopoly stations" do
    @stations.properties[0].name.should eq("station south")
  end
  it "Station west moet het tweede station zijn van de verzameling Monopoly stations" do
    @stations.properties[1].name.should eq("station west")
  end
  it "Station noord moet het derde station zijn van de verzameling Monopoly stations" do
    @stations.properties[2].name.should eq("station north")
  end
  it "Station oost moet het tweede station zijn van de verzameling Monopoly stations" do
    @stations.properties[3].name.should eq("station east")
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
  it "De laatste nog actieve speler moet de winnaar zijn van het spel" do
    @monopoly.winner?.should be_true
  end
  it "Het Monopoly spel moet afgelopen zijn wanneer er een winner bekend is." do
    expect { @monopoly.throw_dice }.to raise_error("game played")
  end
end


