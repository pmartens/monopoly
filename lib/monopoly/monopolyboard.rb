module Monopoly
  class MonopolyBoard < Game::GameBoard
  
    def initialize
      add_space(StartSpace.new)
      add_space(Space.new("veld2"))
      add_space(IncomeTaxSpace.new)
      add_space(Space.new("veld4"))   
      add_space(LuxuryTaxSpace.new)
      (6..20).each do |i|
        add_space(Space.new("veld#{i}"))
      end
      add_space(FreeParkingSpace.new)
      (22..40).each do |i|
         add_space(Space.new("veld#{i}"))
      end  
      
    end
  end    
end