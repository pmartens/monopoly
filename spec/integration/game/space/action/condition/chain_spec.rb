require File.expand_path(File.dirname(__FILE__) + '/../../../../../spec_helper')

describe "Game::Space::Action::Condition::Chain" do

  it "1. When add 3 satisfied conditions the statisfy must return true  " do
    boardgame = double("boardgame")
    space = double("space")

    chain = Game::Space::Action::Condition::Chain.new
    c = Game::Space::Action::Condition::Condition.new(boardgame)

    chain.add_condition(c)
    chain.add_condition(c)
    chain.add_condition(c)

    chain.satisfy(space).should be true

  end

  it "2. When add 2 satisfied 1 not satisfied conditions the statisfy must return false  " do
    boardgame = double("boardgame")
    space = double("space")

    chain = Game::Space::Action::Condition::Chain.new
    c = Game::Space::Action::Condition::Condition.new(boardgame)
    chain.add_condition(c)
    chain.add_condition(c)
    chain.add_condition(c)

    chain.satisfy(space).should be true

  end



end