require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "Monopoly::Start - " do

  before do
    players = []
    (1..3).each do |i|
      players << Monopoly::Player.new("player#{i}")
    end
    settings = Monopoly::Settings.new(players)
    @monopoly = Monopoly::Monopoly.new(settings)
  end
 
  it "1. When player passes startspace the player receives 100$." do
    @monopoly.settings.players[0].pay_money 1500
    start = Monopoly::Space::Start.new(@monopoly)
    start.pass_action
    @monopoly.settings.players[0].money.should eq(100)
  end

  it "2. When player land on startspacce the player receives $200." do
    @monopoly.settings.players[0].pay_money 1500
    start = Monopoly::Space::Start.new(@monopoly)
    start.land_action
    @monopoly.settings.players[0].money.should eq(200)
  end
 
end