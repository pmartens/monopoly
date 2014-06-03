require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "Monopoly:Space:AdditionalRent." do
  before do
    players = []
    @player1 = Monopoly::Player.new("player1")
    players << @player1
    @player2 = Monopoly::Player.new("player2")
    players << @player2
    settings = Monopoly::Settings.new(players)
    @monopoly = Monopoly::Monopoly.new(settings)
  end

  it "get_receiver() Als player 1 de verhoogde huur ontvanger is dan moet deze worden terug gegeven." do
    additionalrent = Monopoly::Space::AdditionalRent.new(@monopoly, 0)
    allow(additionalrent).to receive(:receiver) {@player1}
    additionalrent.receiver().should eq(@player1)
  end

  it "land_action() ALs player 1 land op het 'verhoogde huur' vakje dan is hij de verhoogde huur ontvanger." do
    additionalrent = Monopoly::Space::AdditionalRent.new(@monopoly, 0)
    additionalrent.land_action()
    additionalrent.receiver().should eq(@player1)
  end

  it "get_rent_percentage() Als een verhoorgde huur percentage van 1% is meegegeven dan moet deze 1% retourneren." do
    additionalrent = Monopoly::Space::AdditionalRent.new(@monopoly, 1)
    additionalrent.rent_percentage().should eq(1)
  end

  it "get_rent_percentage() Als een verhoorgde huur percentage van 0% is meegegeven dan moet deze 0% retourneren." do
    additionalrent = Monopoly::Space::AdditionalRent.new(@monopoly, 0)
    additionalrent.rent_percentage().should eq(0)
  end

  it "get_rent_percentage() Als er geen verhoorgde huur percentage is meegegeven dan moet deze 0% retourneren." do
    additionalrent = Monopoly::Space::AdditionalRent.new(@monopoly, nil)
    additionalrent.rent_percentage().should eq(0)
  end
end