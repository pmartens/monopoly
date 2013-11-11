module Monopoly
  class Settings < Game::Settings
    
    def gameboard
      MonopolyBoard.new
    end
    
    def dice
      Game::DuoTraditionalDice.new
    end
        
    def start_fund
      1500
    end
    
    def initialize(players)
      raise "play with at least 2 players" unless players.count > 1
      raise "Play with up to 8 players" unless players.count < 9
      super
    end
      
  end
end