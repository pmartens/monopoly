#require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + '/../../../../spec_helper')

describe "Game::Space::Action::Executor" do

  before do
    @players = []
    @players << Game::Player.new("player1")
    @players << Game::Player.new("player2")
    settings = Game::Settings.new(@players, Game::TraditionalDie.new)

    @boardgame = Game::BoardGame.new(settings)

    action = Game::Space::SpaceAction.new("target")
    action.add_condition(Game::Space::Action::Condition::OnTargetPosition.new(@boardgame))

    @default_actionlist = []
    @default_actionlist << action

    @boardgame.gameboard.add_space(Game::Space::Space.new(@boardgame, "space0"))
    @boardgame.gameboard.add_space(Game::Space::Space.new(@boardgame, "space1"))
    @boardgame.gameboard.add_space(Game::Space::Space.new(@boardgame, "space2"))

  end

  # Test execute
  it "1. When player throws 2 and his start.rb position is start.rb then de the new position is 2." do
    @players[0].position = 0
    allow(@boardgame).to receive(:active_player) {@players[0]}
    allow(@boardgame.settings.dice).to receive(:value) {2}
    executor = Game::Space::Action::Executor.new(@boardgame, @default_actionlist)
    @boardgame.gameboard.set_space_action_executor(executor)
    executor.execute
    @players[0].position.should be(2)
  end

  # Test execute
  it "2. When player throws 2 and his start.rb position is start.rb then de the new position is 2 and turn will be finished." do
    @players[0].position = 0
    allow(@boardgame).to receive(:active_player) {@players[0]}
    allow(@boardgame.settings.dice).to receive(:value) {2}
    executor = Game::Space::Action::Executor.new(@boardgame, @default_actionlist)
    @boardgame.gameboard.set_space_action_executor(executor)
    executor.execute
    executor.turn_finished?.should be_true
  end

  # Test add_extra_throw
  # Test turn_finished?
  it "3. When add extra throw after one execute the turn is not finished." do
    @players[0].position = 0
    allow(@boardgame).to receive(:active_player) {@players[0]}
    allow(@boardgame.settings.dice).to receive(:value) {2}
    executor = Game::Space::Action::Executor.new(@boardgame, @default_actionlist)
    @boardgame.gameboard.set_space_action_executor(executor)
    executor.execute
    executor.add_extra_throw
    executor.turn_finished?.should be_false
  end

  # Test add_extra_throw(actionlist)
  # Test turn_finished?
  it "4. When add extra throw after second execute the turn is finished." do
    @players[0].position = 0
    allow(@boardgame).to receive(:active_player) {@players[0]}
    allow(@boardgame.settings.dice).to receive(:value) {2}
    executor = Game::Space::Action::Executor.new(@boardgame, @default_actionlist)
    @boardgame.gameboard.set_space_action_executor(executor)
    executor.execute
    executor.add_extra_throw(@default_actionlist)
    executor.execute
    executor.turn_finished?.should be_true
  end






end