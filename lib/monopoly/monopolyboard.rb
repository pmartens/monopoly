module Monopoly
  class MonopolyBoard < Game::GameBoard

    def initialize(monopoly)
      super(monopoly)

      always = Game::Space::SpaceAction.new("always")
      always.add_condition(Game::Space::Action::Condition::Always.new(@boardgame))

      start = Game::Space::SpaceAction.new("start_spec.rb")
      start.add_condition(Game::Space::Action::Condition::OnStartPosition.new(@boardgame))

      pass = Game::Space::SpaceAction.new("pass")
      pass.add_condition(Game::Space::Action::Condition::OnPassPosition.new(@boardgame))

      target = Game::Space::SpaceAction.new("target")
      target.add_condition(Game::Space::Action::Condition::OnTargetPosition.new(@boardgame))

      default_actionlist = []
      default_actionlist << always
      default_actionlist << start
      default_actionlist << pass
      default_actionlist << target

      set_space_action_executor(Game::Space::Action::Executor.new(@boardgame, default_actionlist))

      # Create Cities
      onsdorp   = Space::Property::PropertyGroup.new("Ons Dorp")
      arnhem    = Space::Property::PropertyGroup.new("Arnhem")
      haarlem   = Space::Property::PropertyGroup.new("Haarlem")
      utrecht   = Space::Property::PropertyGroup.new("Utrecht")
      groningen = Space::Property::PropertyGroup.new("Groningen")
      denhaag   = Space::Property::PropertyGroup.new("Den Haag")
      rotterdam = Space::Property::PropertyGroup.new("Rotterdam")
      amsterdam = Space::Property::PropertyGroup.new("Amsterdam")

      # Create streets
      dorpstraat        = Space::Street.new(@boardgame, onsdorp, "Dorpstraat", 10, 2)
      brink             = Space::Street.new(@boardgame, onsdorp, "Brink", 15, 2)
      steenstraat       = Space::Street.new(@boardgame, arnhem, "Steenstraat", 20, 3)
      ketelstraat       = Space::Street.new(@boardgame, arnhem, "Ketelstraat", 25, 3)
      velperplein       = Space::Street.new(@boardgame, arnhem, "Velperplein", 30, 3)
      barteljorisstraat = Space::Street.new(@boardgame, haarlem, "Barteljorisstraat", 35, 4)
      zijlweg           = Space::Street.new(@boardgame, haarlem, "Zijlweg", 40, 4)
      houtstraat        = Space::Street.new(@boardgame, haarlem, "Houtstraat", 45, 4)
      neude             = Space::Street.new(@boardgame, utrecht, "Neude", 50, 5)
      bilstraat         = Space::Street.new(@boardgame, utrecht, "Biltstraat", 55, 5)
      vreeburg          = Space::Street.new(@boardgame, utrecht, "Vreeburg", 60, 5)
      akerkhof          = Space::Street.new(@boardgame, groningen, "A Kerkhof", 65, 6)
      grotemarkt        = Space::Street.new(@boardgame, groningen, "Grote Markt", 70, 6)
      heerestraat       = Space::Street.new(@boardgame, groningen, "Heerestraat", 75, 6)
      spui              = Space::Street.new(@boardgame, denhaag, "Spui", 80, 7)
      plein             = Space::Street.new(@boardgame, denhaag, "Plein", 85, 7)
      langepoten        = Space::Street.new(@boardgame, denhaag, "Lange Poten", 90, 7)
      hofplein          = Space::Street.new(@boardgame, rotterdam, "Hofplein", 95, 8)
      blaak             = Space::Street.new(@boardgame, rotterdam, "Blaak", 100, 8)
      coolsingel        = Space::Street.new(@boardgame, rotterdam, "Coolsingel", 105, 8)
      leidschestraat    = Space::Street.new(@boardgame, amsterdam, "Leidschestraat", 110, 9)
      kalverstraat      = Space::Street.new(@boardgame, amsterdam, "Kalverstraat", 115, 10)

      # Adding streets to cities
      onsdorp.add_property(dorpstraat)
      onsdorp.add_property(brink)
      arnhem.add_property(steenstraat)
      arnhem.add_property(ketelstraat)
      arnhem.add_property(velperplein)
      haarlem.add_property(barteljorisstraat)
      haarlem.add_property(zijlweg)
      haarlem.add_property(houtstraat)
      utrecht.add_property(neude)
      utrecht.add_property(bilstraat)
      utrecht.add_property(vreeburg)
      groningen.add_property(akerkhof)
      groningen.add_property(grotemarkt)
      groningen.add_property(heerestraat)
      denhaag.add_property(spui)
      denhaag.add_property(plein)
      denhaag.add_property(langepoten)
      rotterdam.add_property(hofplein)
      rotterdam.add_property(blaak)
      rotterdam.add_property(coolsingel)
      amsterdam.add_property(leidschestraat)
      amsterdam.add_property(kalverstraat)

      # Create Train Stations
      stations = Space::Property::PropertyGroup.new("Stations")
      station_south = Space::Station.new(@boardgame, stations, "station south")
      station_west  = Space::Station.new(@boardgame, stations, "station west")
      station_north = Space::Station.new(@boardgame, stations, "station north")
      station_east  = Space::Station.new(@boardgame, stations, "station east")

      # Create Utilities
      utilities = Space::Property::PropertyGroup.new("utilities")
      electric = Space::Utility.new(@boardgame, utilities, "electric utility")
      water    = Space::Utility.new(@boardgame, utilities, "water utility")

      # Create Jail spaces
      jail = Space::Jail.new(@boardgame)
      gotojail = Space::GoToJail.new(@boardgame, jail)

      # Add spaces
      add_space(Space::Start.new(@boardgame))
      add_space(dorpstraat)
      add_space(Game::Space::Space.new(@boardgame, "fonds"))
      add_space(brink)
      add_space(Space::Tax.new(@boardgame, "incometax", 200))
      add_space(station_south)
      add_space(steenstraat)
      add_space(Game::Space::Space.new(@boardgame, "kans"))
      add_space(ketelstraat)
      add_space(velperplein)
      add_space(gotojail)
      add_space(barteljorisstraat)
      add_space(electric)
      add_space(zijlweg)
      add_space(houtstraat)
      add_space(station_west)
      add_space(neude)
      add_space(Game::Space::Space.new(@boardgame, "fonds"))
      add_space(bilstraat)
      add_space(vreeburg)
      add_space(Space::FreeParking.new(@boardgame))
      add_space(akerkhof)
      add_space(Game::Space::Space.new(@boardgame, "kans"))
      add_space(grotemarkt)
      add_space(heerestraat)
      add_space(station_north)
      add_space(spui)
      add_space(plein)
      add_space(water)
      add_space(langepoten)
      add_space(jail)
      add_space(hofplein)
      add_space(blaak)
      add_space(Game::Space::Space.new(@boardgame, "fonds"))
      add_space(coolsingel)
      add_space(station_east)
      add_space(Game::Space::Space.new(@boardgame, "kans"))
      add_space(leidschestraat)
      add_space(Space::Tax.new(@boardgame, "luxurytax", 100))
      add_space(kalverstraat)

    end
  end
end