class MonopolyBoard < GameBoard
  
  attr_accessor :pot
  
  def spaces
    # Using with 40 spaces
    spaces = []
    spaces << StartSpace.new
    spaces << MonopolySpace.new( "veld2")
    spaces << IncomeTaxSpace.new
    spaces << MonopolySpace.new( "veld4")    
    spaces << LuxuryTaxSpace.new
    (6..20).each do |i|
      spaces << MonopolySpace.new( "veld#{i}")
    end
    spaces << FreeParkingSpace.new
    (22..40).each do |i|
      spaces << MonopolySpace.new( "veld#{i}")
    end
    spaces
  end
  
  def pot
    @pot || @pot = Pot.new
  end
  
end