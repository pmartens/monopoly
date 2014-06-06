#require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Monopoly::Monopoly ->" do

  before do
    players = []
    (1..3).each do |i|
      players << Monopoly::Player.new("player#{i}")
    end
    settings = Monopoly::Settings.new(players)
    @monopoly = Monopoly::Monopoly.new(settings)
  end

  # Intialize settings
  it "1. Monopoly exists of 40 spaces" do
    @monopoly.gameboard.space_count.should eq(40)
  end

  it "2. Monopoly will be played with two dices?" do
    @monopoly.settings.dice.class.should eq(Game::DuoTraditionalDice.new.class)
  end

  # restart game
  it "3. When a game starts each player as an initial amount of 1500." do
    @monopoly.settings.players[0].money.should eq(1500)
    @monopoly.settings.players[1].money.should eq(1500)
    @monopoly.settings.players[2].money.should eq(1500)
  end

  # winner
  it "4. The game is won when only one player has sufficient funds." do
    @monopoly.settings.players[1].pay_money(1600)
    @monopoly.settings.players[2].pay_money(1600)
    @monopoly.winner.should eq(@monopoly.settings.players[0])
  end

  it "5. There is no winner if more then two players are not bankrupt." do
    @monopoly.settings.players[1].pay_money(1600)
    @monopoly.winner.should be_nil
  end

  it "6. Give message 'Game played' when there is a winner." do
    @monopoly.settings.players[1].pay_money(1600)
    @monopoly.settings.players[2].pay_money(1600)
    expect { @monopoly.throw_dice }.to raise_error("game played")
  end

  # next_player
  it "7. A player may throw again when he throws double." do
    allow(@monopoly.settings.dice).to receive(:value) {2}
    allow(@monopoly.settings.dice).to receive(:double?) {true}
    @monopoly.throw_dice
    @monopoly.active_player.should eq(@monopoly.settings.players[0])
  end

  it "8. A player may NOT throw again when he throws NOT double." do
    allow(@monopoly.settings.dice).to receive(:value) {3}
    allow(@monopoly.settings.dice).to receive(:double?) {false}
    @monopoly.throw_dice
    @monopoly.active_player.should eq(@monopoly.settings.players[1])
  end

end