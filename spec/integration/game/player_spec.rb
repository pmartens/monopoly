#require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Game::Player ->" do

  before do
    @players = []
    (1..2).each do |i|
      @players << Game::Player.new("player#{i}")
    end
  end

  it "When player without name joins the game an exception will be raised" do
    expect { Game::Player.new('') }.to raise_error("Player name empty!")
  end

  it "When player with name joins the game no exception will be raised" do
    expect { Game::Player.new('test') }.to_not raise_error("Player name empty!")
  end

end
