class MonopolyBoard < GameBoard
  
  def spaces
    # Using with 40 spaces
    spaces = []
    (1..40).each do |i|
      spaces << Space.new( "veld#{i}" )
    end
    spaces
  end
  
end