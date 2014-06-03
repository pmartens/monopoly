require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "Monopoly::Space::Station - " do

  before do
    players = []
    (1..3).each do |i|
      players << Monopoly::Player.new("player#{i}")
    end
    settings = Monopoly::Settings.new(players)
    @monopoly = Monopoly::Monopoly.new(settings)
  end

  it "1. When player2 lands on station where player1 is owner on only this station. He must pay the interest" do
    @monopoly.settings.players[0].reset
    @monopoly.settings.players[1].reset
    @monopoly.settings.players[0].receive_money 10
    @monopoly.settings.players[1].receive_money 2
    properties = Monopoly::Space::Property::PropertyGroup.new("test")
    station = Monopoly::Space::Station.new(@monopoly, properties, "station1")
    properties.add_property(station)
    station.land_action
    allow(@monopoly).to receive(:active_player) {@monopoly.settings.players[1]}
    station.land_action
    @monopoly.settings.players[1].money.should eq(0)
  end

  it "2. Wanneer een tweede speler op een station vakje land en de eigenaar is in het bezit van 2 stations dan moet de dubble rente worden betaald." do
    @monopoly.settings.players[0].reset
    @monopoly.settings.players[1].reset
    @monopoly.settings.players[0].receive_money 20
    @monopoly.settings.players[1].receive_money 4
    properties = Monopoly::Space::Property::PropertyGroup.new("test")
    station1 = Monopoly::Space::Station.new(@monopoly, properties, "station1")
    station2 = Monopoly::Space::Station.new(@monopoly, properties, "station2")
    properties.add_property(station1)
    properties.add_property(station2)
    station1.land_action
    station2.land_action
    allow(@monopoly).to receive(:active_player) {@monopoly.settings.players[1]}
    station1.land_action
    @monopoly.settings.players[1].money.should eq(0)
  end

  it "3. Wanneer een tweede speler op een station vakje land en de eigenaar is in het bezit van 3 stations dan moet 3 maal de rente worden betaald." do
    @monopoly.settings.players[0].reset
    @monopoly.settings.players[1].reset
    @monopoly.settings.players[0].receive_money 30
    @monopoly.settings.players[1].receive_money 6
    properties = Monopoly::Space::Property::PropertyGroup.new("test")
    station1 = Monopoly::Space::Station.new(@monopoly, properties, "station1")
    station2 = Monopoly::Space::Station.new(@monopoly, properties, "station2")
    station3 = Monopoly::Space::Station.new(@monopoly, properties, "station3")
    properties.add_property(station1)
    properties.add_property(station2)
    properties.add_property(station3)
    station1.land_action
    station2.land_action
    station3.land_action
    allow(@monopoly).to receive(:active_player) {@monopoly.settings.players[1]}
    station1.land_action
    @monopoly.settings.players[1].money.should eq(0)
  end

end