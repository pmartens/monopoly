#require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Phase 2: Kapitaal ->" do
  
  before do    
    @players = []
    (1..2).each do |i|
      @players << Player.new("player#{i}")
    end
    @monopoly = Monopoly.new(@players)
  end  

  it "Monopoly startkapitaal bedraagt $1500" do
    @monopoly.start_fund.should eq(1500)
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
    space.owner.should eq(:bank)
  end
  
  it "Kan een standaard monopoly speelvak een passeer waarde krijgen die negatief en postief kan zijn" do
    space = MonopolySpace.new(:test)
    space.pass_value = 1
    space.pass_value.should eq(0)  
    space.pass_value = -2
    space.pass_value.should eq(0)  
    space.pass_value = 0
    space.pass_value.should eq(0)         
    # space.pass_value(nil)
    # space.pass_value.should eq(0)         
  end
  
  it "Kan een monopoly speelvlak een landings waarde krijgen die negatief en positief kan zijn" do
    space = MonopolySpace.new(:test)
    space.land_value = 1
    space.land_value.should eq(0)  
    space.land_value = -1
    space.land_value.should eq(0)  
    space.land_value = 0
    space.land_value.should eq(0)         
    # space.land_value(nil)
    # space.land_value.should eq(0)             
  end
  
  it "Is er een vakje Start?" do
    start = StartSpace.new
    start.name.should eq(:start)
  end
  
  it "Heeft het vakje start een passeer waarde van $100?" do
    start = StartSpace.new
    start.pass_value.should eq(100)    
  end
   
  it "Heeft het vakje start een landings waarde van $200?" do
    start = StartSpace.new
    start.land_value.should eq(200)
  end
  
  it "Is er een vakje vrijparkeren" do
    freeparking = FreeParkingSpace.new
    freeparking.name.should eq(:freeparking)
  end
  
  it "Heeft het vakje vrijparkeren een passeer waarde" do
    freeparking = FreeParkingSpace.new
    freeparking.pass_value.should eq(0)    
  end
  
  it "De pot is eigenaar het vakje vrijparkeren" do
    freeparking = FreeParkingSpace.new
    freeparking.owner.should eq(:pot)
  end
  
  it "Is er een vakje inkomsten belasting" do
    incometax = IncomeTaxSpace.new
    incometax.name.should eq(:incometax)
  end
  
  it "Heeft het vakje inkomsten belasting landings waarde van -$200?" do
    incometax = IncomeTaxSpace.new
    incometax.land_value.should eq(-200)
  end
  
  it "Heeft het vakje inkomsten belasting een passeer waarde" do
    incometax = IncomeTaxSpace.new
    incometax.pass_value.should eq(0)    
  end
  
  it "De pot is eigenaar het vakje vrijparkeren" do
    incometax = IncomeTaxSpace.new
    incometax.owner.should eq(:pot)
  end
  
  it "Is er een vakje extra belasting" do
    luxurytax = LuxuryTaxSpace.new
    luxurytax.name.should eq(:luxurytax)
  end
 
  it "Heeft het vakje extra belasting een landings waarde van -$100?" do
    luxurytax = LuxuryTaxSpace.new
    luxurytax.land_value.should eq(-100)
  end
  
  it "Heeft het vakje extra belasting een passeer waarde" do
    luxurytax = LuxuryTaxSpace.new
    luxurytax.pass_value.should eq(0)    
  end

  it "De pot is eigenaar het vakje extra belasting" do
    luxurytax = LuxuryTaxSpace.new
    luxurytax.owner.should eq(:pot)
  end
  
  it "Is er een pot aanwezig waarin geld verzameld kan worden?" do
    pot = Pot.new
    pot.money_in(1)
    pot.money.should eq(1)
    pot.money_in(0)
    pot.money.should eq(1)
    pot.money_in(-1)
    pot.money.should eq(1)
    pot.money_in(1)
    pot.money.should eq(2)
  end
  
  it "De pot leeg gehaald kunnen worden" do
    pot = Pot.new
    pot.money_in(1)
    pot.money_out.should eq(1)
    pot.money.should eq(0)
  end
  
  it "Het vakje vrijparkeren moet de pot inhoud uitkeren bij een landings actie" do
    freeparking = FreeParkingSpace.new
    freeparking.land_value = 1
    freeparking.land_value.should eq(1)        
    freeparking.land_value = 0
    freeparking.land_value.should eq(0)    
    freeparking.land_value = -1
    freeparking.land_value.should eq(0)    
  end
  
  it "Kan er gameboard speelvak worden opgevraagd" do
    space = Space.new(:start)
    gameboard = GameBoard.new
    gameboard.add_space(space)
    gameboard.space(:start).should eq(:start)
  end
  
  it "Heeft het monopoly board een start vakje" do
    
    @monopoly.gameboard.space(:start).should eq(:start)
  end
  
  it "Heeft het monopoly board een start vakje" do
    @monopoly.gameboard.space(:start).should eq(:start)
  end
  
  it "Heeft het monopoly board een vrijparkeren vakje" do
    @monopoly.gameboard.space(:freeparking).should eq(:freeparking)
  end
  
  it "Heeft het monopoly board een inkomsten belasting vakje" do
    @monopoly.gameboard.space(:incometax).should eq(:incometax)
  end
  
  it "Heeft het monopoly board een extra belasting vakje" do
    @monopoly.gameboard.space(:luxurytax).should eq(:luxurytax)
  end

  it "Kan een speler een nieuwe speel positie krijgen?" do
    player = Player.new("player1")
    player.position = 2
    player.position.should eq(2)
  end
  
  it "Bij starten monopoly heeft ieder een startkapitaal van $1500" do
    monopoly = Monopoly.new(@players)
    monopoly.players.each{ |player| player.money.should eq(1500) }
  end
  
  it "Indien een speler het maximaal aantal speel vakken heeft bereikt bij een standaar gameboard moet deze weer bij het eerste speel vak verder kunnen gaan " do
    
    #mock
    dice = Dice.new
    dice.add_die(TraditionalDie.new)
    dice.add_die(TraditionalDie.new)
    boardgame = BoardGame.new(@players)
    boardgame.gameboard = MonopolyBoard.new
    boardgame.dice = dice
    boardgame.next_player_turn(boardgame.players.first)
    boardgame.throw_dice
    #  
    
    # pos + 1
    boardgame.players.first.position = 38
    boardgame.move_player_position(1)
    boardgame.players.first.position.should eq(39)    
    # pos + 2 = maxcount
    boardgame.players.first.position = 38
    boardgame.move_player_position(2)
    boardgame.players.first.position.should eq(0)
    # pos + 3 = 1
    boardgame.players.first.position = 38
    boardgame.move_player_position(3)
    boardgame.players.first.position.should eq(1)
  end
  
  it "Ontvangt een speler een bedrag van $100 wanneer deze het vakje start passeert?" do    
    #mock
    @monopoly.next_player_turn(@monopoly.players.first)
    @monopoly.throw_dice
    # score + 3 = 1
    @monopoly.players.first.money = 1500
    @monopoly.players.first.position = 38
    @monopoly.move_player_position(3)
    @monopoly.players.first.position.should eq(1)
    @monopoly.players.first.money.should eq(1600)
  end
  
  # 
  # it "Ontvangt een speler een bedrag van $200 wanneer deze op het vakje start komt?" do
  #   #mock
  #   @monopoly.players.first.position = 38
  #   @monopoly.next_player_turn(@monopoly.players.first)
  #   @monopoly.throw_dice
  #   # score is + 2 = start 
  #   #
  #   @monopoly.move_player_position
  #   @monopoly.players.first.money.should(1700)
  # end
  # 
  # 
  # 
  # it "Kapitaal correct na betalen belasting?" do
  #   #mock
  #   @monopoly.players.first.position = 38
  #   @monopoly.next_player_turn(@monopoly.players.first)
  #   @monopoly.throw_dice
  #   # score is bel
  #   #
  #   @monopoly.move_player_position
  #   @monopoly.players.first.money.should(1300)
  # end
  # 
  # it "Pot extra gevuld na betalen belasting?" do
  #   #mock
  #   @monopoly.next_player_turn(@monopoly.players.first)
  #   @monopoly.throw_dice
  #   # score is belasting 
  #   #
  #   @monopoly.move_player_position
  #   @monopoly.gameboard.pot.money.should eq(200)
  # end
  # 
  #  
  # it "Kapitaal correct na ontvangen vrij parkeren?" do
  #   player_money = @monopoly.players.first.money
  #   @monopoly.next_player_turn(@monopoly.players.first)
  #   @monopoly.gameboard.pot.money = 200
  #   @monopoly.players.first.current_position = 10
  #   @monopoly.score = @score
  #   @monopoly.round = 10
  #   @monopoly.move_player_position
  #   @monopoly.players.first.money.should eq(player_money + 200)
  # end  
  # 
  # it "Kapitaal correct na betalen extra belasting?" do
  #   @monopoly.gameboard.pot.money = 0
  #   @monopoly.players.first.money = @monopoly.start_seed
  #   @monopoly.players.first.pay(@luxurytax.land_value(@monopoly))
  #   @monopoly.players.first.money.should eq(1400)
  # end
  # 
  # it "Pot extra gevuld na betalen extra belasting?" do
  #   @monopoly.gameboard.pot.money = 0
  #   @monopoly.players.first.money = @monopoly.start_seed
  #   @monopoly.players.first.pay(@luxurytax.land_value(@monopoly))
  #   @monopoly.gameboard.pot.money.should eq(100)
  # end
  
end
