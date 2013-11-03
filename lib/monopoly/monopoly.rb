class Monopoly < BoardGame

  def initialize(settings)
    super
    set_players_start_fund
  end  
  
  protected
  
  def set_players_start_fund
    @players.each do |player|
      player.receive_money = @start_fund
    end
  end
  
  def next_player
    super unless @dice.double?
  end
    
end