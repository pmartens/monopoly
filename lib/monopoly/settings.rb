module Monopoly
  class Settings < Game::Settings
    
    def gameboard
      Monopoly::Board.new
    end
    
    def dice
      Game::TraditionalDuoDice.new
    end
    
    def min_players
      2
    end
    
    def max_player
      8
    end
    
    def start_fund
      1500
    end
    
    def initialize(players)
      super
      raise "play with at least #{min_players.to_s} players" unless @players.count >= @min_players 
      raise "Play with up to #{max_players.to_s} players" unless @players.count <= @max_players 
    end
      
  end
end