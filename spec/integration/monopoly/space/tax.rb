require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "Monopoly::Space::Tax - " do

  before do
    players = []
    (1..3).each do |i|
      players << Monopoly::Player.new("player#{i}")
    end
    settings = Monopoly::Settings.new(players)
    @monopoly = Monopoly::Monopoly.new(settings)
  end

  it "1. When player lands on taxspace the player must $100." do
    @monopoly.settings.players[0].pay_money 1400
    start = Monopoly::Space::Tax.new(@monopoly, "tax", 100)
    start.land_action
    @monopoly.settings.players[0].money.should eq(0)
  end

end