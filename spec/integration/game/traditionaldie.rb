require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Game::TraditionalDie - " do

  it "1. When throw a traditional die the value should between 1 and 6." do
    die = Game::TraditionalDie.new
    die.throw_die.should be_between(1, 6)
  end

end
