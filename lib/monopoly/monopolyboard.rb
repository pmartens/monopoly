module Monopoly
  class MonopolyBoard < Game::GameBoard
  
    attr_accessor :pot
  
    def initialize(game)
      add_space(Monopoly::StartSpace.new(game))
      add_space(Monopoly::Space.new("veld2", game))
      add_space(Monopoly::IncomeTaxSpace.new(game))
      add_space(Monopoly::Space.new("veld4", game))   
      add_space(Monopoly::LuxuryTaxSpace.new(game))
      (6..20).each do |i|
        add_space(Monopoly::Space.new("veld#{i}", game))
      end
      add_space(Monopoly::FreeParkingSpace.new(game))
      (22..40).each do |i|
        add_space(MonopolySpace.new("veld#{i}", game))
      end  
      @pot = Monopoly::Pot.new
    end
      
end