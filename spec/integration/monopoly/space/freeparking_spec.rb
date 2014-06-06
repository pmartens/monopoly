require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "Monopoly::FreeParking - " do

  before do
    players = []
    (1..3).each do |i|
      players << Monopoly::Player.new("player#{i}")
    end
    settings = Monopoly::Settings.new(players)
    @monopoly = Monopoly::Monopoly.new(settings)
  end

  it "1. When player lands on freeparking space the player gets the pot." do
    @monopoly.settings.players[0].pay_money 1500
    @monopoly.pot.money_in(1)
    start = Monopoly::Space::FreeParking.new @monopoly
    start.land_action
    @monopoly.settings.players[0].money.should eq(1)
  end

end