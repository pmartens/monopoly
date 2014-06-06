#require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Game::Boardgame ->" do

  before do
    @players = []
    (1..2).each do |i|
      @players << Game::Player.new("player#{i}")
    end
    @settings = Game::Settings.new(@players, double("dice"))
  end

  it "1. When start_spec.rb a game player 1 starts the game?" do
    game = Game::BoardGame.new(@settings)
    game.active_player.should eq(@players[0])
  end


end