require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "Monopoly::Space::Jail - " do
  before do
    players = []
    (1..3).each do |i|
      players << Monopoly::Player.new("player#{i}")
    end
    settings = Monopoly::Settings.new(players)
    @monopoly = Monopoly::Monopoly.new(settings)
  end

  it "1. When a player lands on go to jail space the player will moved to jail." do
    @monopoly.settings.players[0].position = 1
    gotojail = @monopoly.gameboard.space(10)
    jail =  @monopoly.gameboard.space(30)
    gotojail.land_action
    @monopoly.settings.players[0].position.should eq(@monopoly.gameboard.space_index(jail))
  end


end