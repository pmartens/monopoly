#require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Phase 1: Board and move ->" do
  
  before do    
    @players = []
    (1..2).each do |i|
      @players << Player.new("player#{i}")
    end
    @dryrun = true # runs only one round
  end  
  
  it "Are the player names correctly filled in?" do
    expect { Player.new('') }.to raise_error("Player name empty!")
  end
  
  it "Can add players to the game" do
    monopoly = Monopoly.new(@players)
    monopoly.players.count.should eq(2)
  end
  
  it "Monopoly settings are correct" do
    monopoly = Monopoly.new(@players)
    monopoly.min_players.should eq(2)
    monopoly.max_players.should eq(8)
    monopoly.gameboard.spaces.count eq(40)
  end
   
  it "There are at least 2 players in the game?" do
    player1 = Player.new("player1")
    players = []
    players << player1            
    expect { Monopoly.new(players) }.to raise_error("play with at least 2 players")
  end
  
  it "Fewer than eight players gives an error message?" do
    players = []
    (1..9).each do |i|
      players << Player.new("player#{i}")
    end
    expect { Monopoly.new(players) }.to raise_error("Play with up to 8 players")
  end
  
  it "The boardgame will be played with two dices?" do
    monopoly = Monopoly.new(@players)
    monopoly.dice.count.should eq(2)  
  end
  
  it "Has player 1 begin to play?" do
    monopoly = Monopoly.new(@players)
    monopoly.start(@dryrun)
    #First round ends with player 2
    monopoly.turn_player.name.should eq("player2")
  end
  
  it "The total value of the dice throw is not less than 2 and not more then 12?" do
    monopoly = Monopoly.new(@players)
    monopoly.start(@dryrun)
    monopoly.turn_dice_score.should be_between(2, 12)
  end
  
  it "Does the value of each die throw between 1 t / m 6?" do 
    monopoly = Monopoly.new(@players)
    monopoly.start(@dryrun)
    score = monopoly.turn_each_die_score
    score.each{ |die_score| die_score.should be_between(1, 6) }
  end
  
  it "Does the player have thrown again when both dice have the same value?" do
    monopoly = Monopoly.new(@players)
    player = monopoly.players.first
    monopoly.next_player_turn(player)
    score = []
    monopoly.dice.each{ |die| score << { die => 1 } }
    s = []
    score.each{ |data| data.each{ |key, value| s.concat([value])}}
    s.uniq.count eq(1)
  end
  
  it "player position is correct after throwing?" do
    monopoly = Monopoly.new(@players)
    monopoly.start(@dryrun)
    if monopoly.turn_player.played > 1
      (monopoly.turn_player.current_position - monopoly.turn_player.previous_position).should eq(monopoly.turn_dice_score)
    else
      monopoly.turn_player.current_position.should eq(monopoly.turn_dice_score)
    end
  end 
  
  it "Have al players played after the first round?" do
    monopoly = Monopoly.new(@players)
    monopoly.start(@dryrun)
    monopoly.round?.should eq(1)
    monopoly.players.each do |player|
      player.played.should be > 0
    end
  end
  
  it "when a player has walked through all 40 spaces the player prositions start at 1 again." do
    monopoly = Monopoly.new(@players)
    player = monopoly.players.first
    monopoly.next_player_turn(player)
    score = 44
    #monopoly.move_player_position
    score = monopoly.turn_player.current_position + score
    score = score > monopoly.gameboard.spaces.count ? (monopoly.gameboard.spaces.count - score).abs : score
    #
    monopoly.turn_player.new_position(score)
    monopoly.turn_player.current_position.should eq(4)
  end
  
end
