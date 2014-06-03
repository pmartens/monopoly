require File.expand_path(File.dirname(__FILE__) + '/../../../../spec_helper')

  describe "Monopoly::Space::Property::Property - " do

    before do
      players = []
      (1..3).each do |i|
        players << Monopoly::Player.new("player#{i}")
      end
      settings = Monopoly::Settings.new(players)
      @monopoly = Monopoly::Monopoly.new(settings)
    end

    it "1: Wanneer de eerste speler op het vastgoed vakje land dan is hij/zij automatisch eigenaar." do
      properties = double("properties")
      property = Monopoly::Space::Property::Property.new(@monopoly, properties, "test", 0, 0)
      property.land_action
      property.owner.should eq(@monopoly.active_player)
    end

    it "2: Wanneer de eerste speler op het vastgoed vakje land dan moet hij/zij de aankoopprijs betalen." do
      properties = double("properties")
      @monopoly.settings.players[0].reset
      @monopoly.settings.players[0].receive_money(1)
      property = Monopoly::Space::Property::Property.new(@monopoly, properties, "test", 1, 0)
      property.land_action
      property.owner.should eq(@monopoly.active_player)
    end

    it "3: Wanneer de eerste speler op het vastgoed vakje land dan wordt het aankoop bedrag afgeschreven van zijn saldo." do
      properties = double("properties")
      @monopoly.settings.players[0].reset
      @monopoly.settings.players[0].receive_money(1)
      property = Monopoly::Space::Property::Property.new(@monopoly, properties, "test", 1, 0)
      property.land_action
      @monopoly.settings.players[0].money.should eq(0)
    end

    it "4: Wanneer de eerste speler op het vastgoed vakje land en geen voldoende saldo heeft dan kan hij/zij het vastgoed niet kopen." do
      properties = double("properties")
      @monopoly.settings.players[0].reset
      property = Monopoly::Space::Property::Property.new(@monopoly, properties, "test", 1, 0)
      property.land_action
      property.owner.should be_nil
    end

    it "5: Wanneer een speler2 op het vastgoed vakje land dan moet hij/zij rente betalen aan de eigenaar." do
      @monopoly.settings.players[0].reset
      @monopoly.settings.players[1].reset
      @monopoly.settings.players[1].receive_money(1)
      properties = double("properties")
      property = Monopoly::Space::Property::Property.new(@monopoly, properties, "test", 0, 1)
      property.land_action
      allow(@monopoly).to receive(:active_player) {@monopoly.settings.players[1]}
      property.land_action
      @monopoly.settings.players[1].money.should eq(0)
      @monopoly.settings.players[0].money.should eq(1)
    end

  end