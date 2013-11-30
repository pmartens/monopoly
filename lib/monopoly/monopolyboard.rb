module Monopoly
  class MonopolyBoard < Game::GameBoard

    def initialize(settings)

      # def name
      #   "luxurytax"
      # end
      #
      # def land_value
      #   100
      # end
      # def name
      #   "incometax"
      # end
      #
      # def land_value
      #   200
      # end

      stations = Stations.new(settings)
      utilities = Utilities.new(settings)

      towns = Towns.new(settings)
      streets = towns.all_streets

      add_space(StartSpace.new(settings))
      add_space(streets[1])
      add_space(Space.new(settings, "fonds"))
      add_space(streets[2])
      add_space(IncomeTaxSpace.new(settings))
      add_space(stations.get_property(1))
      add_space(streets[3])
      add_space(Space.new(settings, "kans"))
      add_space(streets[4])
      add_space(streets[5])
      add_space(Space.new(settings, "gevaningenis"))
      add_space(streets[6])
      add_space(utilities.get_property(1))
      add_space(streets[7])
      add_space(streets[8])
      add_space(stations.get_property(2))
      add_space(streets[9])
      add_space(Space.new(settings, "fonds"))
      add_space(streets[10])
      add_space(streets[11])
      add_space(FreeParkingSpace.new(settings))
      add_space(streets[12])
      add_space(Space.new(settings, "kans"))
      add_space(streets[13])
      add_space(streets[14])
      add_space(stations.get_property(3))
      add_space(streets[15])
      add_space(streets[16])
      add_space(utilities.get_property(2))
      add_space(streets[16])
      add_space(Space.new(settings, "to yail"))
      add_space(streets[17])
      add_space(streets[18])
      add_space(Space.new(settings, "fonds"))
      add_space(streets[19])
      add_space(stations.get_property(4))
      add_space(Space.new(settings, "kans"))
      add_space(streets[20])
      add_space(LuxuryTaxSpace.new(settings))
      add_space(streets[21])
    end
  end
end