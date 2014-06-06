#require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Monopoly::Settings - " do

  it "1. When add only one player to the Monopoly game an exception will be raised." do
    players = []
    players << Game::Player.new("player1")
    expect { Monopoly::Settings.new(players) }.to raise_error("play with at least 2 players")
  end

  it "2. When add two players to the Monopoly game the game can be played." do
    players = []
    players << Game::Player.new("player1")
    players << Game::Player.new("player2")
    expect { Monopoly::Settings.new(players) }.to_not raise_error
  end

  it "3. When add 9 player to the Monopoly game an exception will be raised." do
    players = []
    (1..9).each do |i|
      players << Game::Player.new("player#{i}")
    end
    expect { Monopoly::Settings.new(players) }.to raise_error("Play with up to 8 players")
  end

  it "4. When add 8 players to the Monopoly game the game can be played." do
    players = []
    (1..8).each do |i|
      players << Game::Player.new("player#{i}")
    end
    expect { Monopoly::Settings.new(players) }.to_not raise_error
  end

end
