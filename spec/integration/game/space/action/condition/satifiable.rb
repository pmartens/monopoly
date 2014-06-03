#require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + '/../../../../../spec_helper')


describe "Game::Space::Action::Condition::Satisfiable" do

  it "1. Should create new class with Satisfiable interface." do

    class Test < Game::Space::Action::Condition::Satisfiable
      def satisfy(space)
        return true
      end
    end

    space = double("space")
    test = Test.new
    test.satisfy(space).should be true

  end

  it "2. Should raise error when satisfy not exits" do

    class Test < Game::Space::Action::Condition::Satisfiable
    end

    space = double("space")
    expect { Test.new }.not_to raise_exception

  end

end