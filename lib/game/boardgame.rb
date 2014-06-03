module Game
  class BoardGame

    attr_reader :settings
    attr_reader :gameboard

    def initialize(settings, gameboard = nil)
      @settings = settings
      @gameboard = gameboard.nil? ? GameBoard.new(self) : gameboard
      restart_game
    end

    def restart_game
      @throw_indentifier = 0
      @active_player = 0
    end

    def winner
      nil
    end

    def active_player
      @settings.players[@active_player]
    end

    def throw_dice
      raise "game played" unless winner.nil?
      raise "No space action executor defined" if @gameboard.space_action_executor.nil?

      @settings.dice.throw_dice

      # Execute actions on spaces
      @gameboard.space_action_executor.execute()

      # to next player
      next_player if @gameboard.space_action_executor.turn_finished?

    end

    :protected

    def next_player
      @active_player = @active_player == (@settings.players.count-1) ? 0 : @active_player += 1
    end

  end
end