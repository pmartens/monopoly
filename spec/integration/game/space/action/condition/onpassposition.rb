require File.expand_path(File.dirname(__FILE__) + '/../../../../../spec_helper')

describe "Game::Space::Action::Condition::OnPassPosition -> " do

  before do
    @players = []
    @players << Game::Player.new("player1")
    @players << Game::Player.new("player2")
    settings = Game::Settings.new(@players, Game::TraditionalDie.new)
    @boardgame = Game::BoardGame.new(settings)
    @boardgame.gameboard.add_space(Game::Space::Space.new(@boardgame, "space0"))
    @boardgame.gameboard.add_space(Game::Space::Space.new(@boardgame, "space1"))
    @boardgame.gameboard.add_space(Game::Space::Space.new(@boardgame, "space2"))
  end

  it "1. When no space action executor is defined raise an error" do
    expect{Game::Space::Action::Condition::OnTargetPosition.new(@boardgame).satisfy(space)}.to raise_error
  end

  it "2. Condition satifies when space position is between space1 and player target position." do
    allow(@boardgame).to receive(:active_player) {@players[0]}
    allow(@boardgame.settings.dice).to receive(:value) {2}
    target = Game::Space::Action::Condition::OnPassPosition.new(@boardgame)
    allow(target).to receive(:execute_space_actions?) {true}
    target.satisfy(@boardgame.gameboard.space(0)).should be false
    target.satisfy(@boardgame.gameboard.space(1)).should be true
    target.satisfy(@boardgame.gameboard.space(2)).should be false
  end

  it "3. Condition not satisfies when space action is halted" do
    executor = double('space_action_executor', :halt? => true)
    allow(@boardgame.gameboard).to receive(:space_action_executor) {executor}
    allow(@boardgame).to receive(:active_player) {@players[0]}
    allow(@boardgame.settings.dice).to receive(:value) {2}
    target = Game::Space::Action::Condition::OnPassPosition.new(@boardgame)
    target.satisfy(@boardgame.gameboard.space(0)).should be false
    target.satisfy(@boardgame.gameboard.space(1)).should be false
    target.satisfy(@boardgame.gameboard.space(2)).should be false
  end

  it "4. Condition satisfies when space action is not halted" do
    executor = double('space_action_executor', :halt? => false)
    allow(@boardgame.gameboard).to receive(:space_action_executor) {executor}
    allow(@boardgame).to receive(:active_player) {@players[0]}
    allow(@boardgame.settings.dice).to receive(:value) {2}
    target = Game::Space::Action::Condition::OnPassPosition.new(@boardgame)
    target.satisfy(@boardgame.gameboard.space(0)).should be false
    target.satisfy(@boardgame.gameboard.space(1)).should be true
    target.satisfy(@boardgame.gameboard.space(2)).should be false
  end

  # it "5 Condition satisfies when space position between space1 and player target position in second board space round." do
  #   allow(@boardgame).to receive(:active_player) {@players[0]}
  #   allow(@boardgame.settings.dice).to receive(:value) {4}
  #   target = Game::Space::Action::Condition::OnPassPosition.new(@boardgame)
  #   allow(target).to receive(:execute_space_actions?) {true}
  #   target.satisfy(@boardgame.gameboard.space(0)).should be false
  #   target.satisfy(@boardgame.gameboard.space(1)).should be true
  #   target.satisfy(@boardgame.gameboard.space(2)).should be true
  #   target.satisfy(@boardgame.gameboard.space(0)).should be true
  #   target.satisfy(@boardgame.gameboard.space(1)).should be false
  # end

end


