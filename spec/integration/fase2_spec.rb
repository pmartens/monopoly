#require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Phase 2: Kapitaal ->" do
  
  before do    
    @players = []
    (1..2).each do |i|
      @players << Player.new("player#{i}")
    end
    @dryrun = 10 # runs only 10 rounds
    @monopoly = Monopoly.new(@players)
  end  

  it "Monopoly startkapitaal bedraagt $1500" do
    @monopoly.start_seed.should eq(1500)
  end

  it "Heeft een speler een startkapitaal van $1500 gekregen?" do
    player = Player.new("player1")
    player.receive_money(1500)
    player.money.should eq(1500)
  end
  
  it "Waneer een speler een bedrag moet betalen dan gaat dit van zijn kapitaal af" do
    player = Player.new("player1")
    player.receive_money(1)
    player.pay_money(1)
    player.money.should eq(0)
  end
  
  it "Wanneer een speler een bedrag ontvangt dan wordt dit bij zijn kapitaal bijgeschreven" do
    player = Player.new("player1")
    player.receive_money(1)
    player.money.should eq(1)    
  end
  
  it "Er kunnen speelvakken worden aangemaakt met en zonder een naam" do
    space = Space.new(:test)
    space.name.should eq(:test)
    # testen zonder benaming
    # testen met nil
  end
  
  it "Er kunnen monopoly speelvakken worden aangemaakt" do
    space = MonopolySpace.new(:test)  
  end
  
  it "Standaard monopoly speel vakken zijn eigenaar van de bank" do
    space = MonopolySpace.new(:test)
    space.get_owner.should eq(:bank)
  end
  
  it "Kan een monopoly speelvak een passeer waarde krijgen die negatief en postief kan zijn" do
    space = MonopolySpace.new(:test)
    space.add_pass_value(1)
    space.pass_action.should eq(1)  
    space.add_pass_value(-1)
    space.pass_action.should eq(-1)  
    space.add_pass_value(0)
    space.pass_action.should eq(0)         
    # space.add_pass_value(nil)
    # space.pass_action.should eq(0)         
  end
  
  it "Kan een monopoly speelvlak een landings waarde krijgen die negatief en positief kan zijn" do
    space = MonopolySpace.new(:test)
    space.add_land_value(1)
    space.land_action.should eq(1)  
    space.add_land_value(-1)
    space.land_action.should eq(-1)  
    space.add_land_value(0)
    space.land_action.should eq(0)         
    # space.add_land_value(nil)
    # space.land_action.should eq(0)             
  end
  
  it "Is er een vakje Start?" do
    start = StartSpace.new
    start.name.should eq(:start)
  end
  
  it "Heeft het vakje start een passeer waarde van $100?" do
    start = StartSpace.new
    start.pass_action.should eq(100)    
  end
   
  it "Heeft het vakje start een landings waarde van $200?" do
    start = StartSpace.new
    start.land_action.should eq(200)
  end
  
  it "Is er een vakje vrijparkeren" do
    freeparking = FreeparkingSpace.new
    freeparking.name.should eq(:freeparking)
  end
  
  it "Heeft het vakje vrijparkeren een passeer waarde" do
    freeparking = FreeparkingSpace.new
    freeparking.pass_action eq(0)    
  end
  
  it "De pot is eigenaar het vakje vrijparkeren" do
    freeparking = FreeparkingSpace.new
    freeparking.get_owner.should eq(:pot)
  end
  
  it "Is er een vakje inkomsten belasting" do
    incometax = IncomeTaxSpace.new
    incometax.name.should eq(:incometax)
  end
  
  it "Heeft het vakje inkomsten belasting landings waarde van -$200?"
    incometax = IncomeTaxSpace.new
    incometax.land_action.should eq(-200)
  end
  
  it "Heeft het vakje inkomsten belasting een passeer waarde" do
    incometax = IncomeTaxSpace.new
    incometax.pass_action eq(0)    
  end
  
  it "De pot is eigenaar het vakje vrijparkeren" do
    incometax = IncomeTaxSpace.new
    incometax.get_owner.should eq(:pot)
  end
  
  it "Is er een vakje extra belasting" do
    luxurytax = LuxuryTaxSpace.new
    luxurytax.name.should eq(:luxurytax)
  end
 
  it "Heeft het vakje extra belasting een landings waarde van -$100?"
    luxurytax = LuxuryTaxSpace.new
    luxurytax.land_action.should eq(-100)
  end
  
  it "Heeft het vakje extra belasting een passeer waarde" do
    luxurytax = LuxuryTaxSpace.new
    luxurytax.pass_action eq(0)    
  end

  it "De pot is eigenaar het vakje extra belasting" do
    luxurytax = LuxuryTaxSpace.new
    luxurytax.get_owner.should eq(:pot)
  end
  
  it "Is er een pot aanwezig waarin geld verzameld kan worden?" do
    pot = Pot.new
    pot.money_in = 1
    pot.money.should eq(1)
    pot.money_in = 0
    pot.money.should eq(1)
    pot.money_in = -1
    pot.money.should eq(1)
    pot.money_in = 1
    pot.money.should eq(2)
  end
  
  it "De pot leeg gehaald kunnen worden" do
    pot = Pot.new
    pot.money_in = 1
    pot.money_out.should eq(1)
    pot.money.should eq(0)
  end
  
  it "Het vakje vrijparkeren moet de pot inhoud uitkeren bij een landings actie" do
    #mock
    pot = Pot.new
    pot.money_in = 1
    #
    freeparking = FreeparkingSpace.new
    freeparking.land_action(pot).should eq(1)    
    
    #mock 2
    pot2 = Pot.new
    #
    freeparking.land_action(pot2).should eq(0)    
  end
  
  it "Heeft het monopoly board een start vakje" do
    @monopoly.get_space(:start).name.should eq(:start)
  end
  
  it "Heeft het monopoly board een start vakje" do
    @monopoly.get_space(:start).name.should eq(:start)
  end
  
  it "Heeft het monopoly board een vrijparkeren vakje" do
    @monopoly.get_space(:freeparking).name.should eq(:freeparking)
  end
  
  it "Heeft het monopoly board een inkomsten belasting vakje" do
    @monopoly.get_space(:incometax).name.should eq(:incometax)
  end
  
  it "Heeft het monopoly board een extra belasting vakje" do
    @monopoly.get_space(:luxurytax).name.should eq(:luxurytax)
  end
  
  
  # def move_player_position(position)
 #    super
 #    # position starts at 0 so maximum is 1 less
 #    max_pos = (gameboard.spaces_count - 1)
 #    
 #    if position < @player.position
 #      topos = max_pos
 #    else
 #      topos = position
 #    end
 #        
 #    # execute pass actions
 #    pos = (@player.position + 1)
 #      
 #    while pos < topos do
 #      puts "position:#{gameboard.spaces[pos].name}"
 #       
 #      if gameboard.spaces[pos].owner = :owner
 #        gameboard.spaces[pos].owner.add_land_value(gameboard.pot.money)
 #      end
 #      
 #      money = gameboard.spaces[pos].pass_action
 #      if money > 0 
 #        @player.pay_money(money)
 #      else
 #        @player.receive_money(money)
 #      end
 #       
 #      pos += 1
 #      if pos == max_pos && position < @player.position
 #        pos = 0
 #        topos = @position
 #      end
 #    end
 # 
 #    # execute land action
 #    if gameboard.spaces[position].owner = :owner
 #      gameboard.spaces[position].owner.add_land_value(gameboard.pot.money)
 #    end
 # 
 #    money = gameboard.spaces[position].land_action
 #    if money > 0 
 #      @player.pay_money(money)
 #    else
 #      @player.receive_money(money)
 #    end
 # 
 #    @player.position(position)
 #  end
  
  
  
  it "Kapitaal correct na betalen belasting?" do
    @monopoly.
    @monopoly.gameboard.pot.money_in = 0
    @monopoly.players.first.money = @monopoly.start_seed
    @monopoly.players.first.pay(@incometax.land_action(@monopoly))
    @monopoly.players.first.money.should eq(1300)
  end
  
  it "Pot extra gevuld na betalen belasting?" do
    @monopoly.gameboard.pot.money = 0
    @monopoly.players.first.money = @monopoly.start_seed
    @monopoly.players.first.pay(@incometax.land_action(@monopoly))
    @monopoly.gameboard.pot.money.should eq(200)
  end
  
  
  
  before do
    # dice throw off 2 x 5 = 10
    @score = []
    @monopoly.dice.each do |die|
      @score << { die => 5 }
    end
  end
  
  it "Ontvangt een speler een bedrag van $100 wanneer deze het vakje start passeert?" do
    player_money = @monopoly.players.first.money
    @monopoly.next_player_turn(@monopoly.players.first)
    @monopoly.players.first.current_position = 37
    @monopoly.score = @score
    @monopoly.round = 2
    @monopoly.move_player_position
    @monopoly.players.first.money.should eq(player_money + 100)
  end
  
  it "Ontvangt een speler geen $100 wanneer deze de eerste ronde het vakje start passeert?" do
    @dryrun = 1
    @monopoly.start(@dryrun)
    @monopoly.players.first.money.should eq(1500)
  end
  
  it "Ontvangt een speler een bedrag van $200 wanneer deze op het vakje start komt?" do
    player_money = @monopoly.players.first.money
    @monopoly.next_player_turn(@monopoly.players.first)
    @monopoly.players.first.current_position = 30
    @monopoly.score = @score
    @monopoly.round = 10
    @monopoly.move_player_position
    @monopoly.players.first.money.should eq(player_money + 200)
  end
      
  it "Kapitaal correct na ontvangen vrij parkeren?" do
    player_money = @monopoly.players.first.money
    @monopoly.next_player_turn(@monopoly.players.first)
    @monopoly.gameboard.pot.money = 200
    @monopoly.players.first.current_position = 10
    @monopoly.score = @score
    @monopoly.round = 10
    @monopoly.move_player_position
    @monopoly.players.first.money.should eq(player_money + 200)
  end
      
    
  
  it "Kapitaal correct na betalen extra belasting?" do
    @monopoly.gameboard.pot.money = 0
    @monopoly.players.first.money = @monopoly.start_seed
    @monopoly.players.first.pay(@luxurytax.land_action(@monopoly))
    @monopoly.players.first.money.should eq(1400)
  end
  
  it "Pot extra gevuld na betalen extra belasting?" do
    @monopoly.gameboard.pot.money = 0
    @monopoly.players.first.money = @monopoly.start_seed
    @monopoly.players.first.pay(@luxurytax.land_action(@monopoly))
    @monopoly.gameboard.pot.money.should eq(100)
  end
  
end
