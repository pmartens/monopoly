module Monopoly
  module Space
    class Jail < GameSpace

      def initialize(monopoly)
        @prisonerproperties = []
        monopoly.settings.players.each do |player|
          @prisonerproperties << PrisonerProperty.new(player)
        end
        super( monopoly, "Jail")
      end

      def player_can_move
        can_move = true
        jails = []
        jails = @boardgame.gameboard.spaces(@name)
        jails.each do |jail|
          p = jail.find_prisonerproperty
          can_move = false if p.locked_up
        end
        can_move
      end

      def before_action
        # find player settings from all jail spaces
        double_throws = 0
        locked_up_throws = 0
        locked_up = false
        last_changed = false

        jails = []
        jails = @boardgame.gameboard.spaces(@name)
        jails.each do |jail|
          p = jail.find_prisonerproperty
          locked_up_throws = locked_up_throws + p.locked_up_throws
          double_throws = double_throws + p.double_throws
          last_changed = true if p.last_changed
          locked_up = true if p.locked_up
        end

        @prisonerproperties.each do |prisonerproperty|
          prisonerproperty.last_changed = prisonerproperty.player == @boardgame.active_player ? true : false
        end

        prisonerproperty = find_prisonerproperty
        if !last_changed
          prisonerproperty.last_changed = true
          # Actions when player is prisoner
          if locked_up
            if locked_up_throws < 2
              if @boardgame.settings.dice.double?
                jails.each do |jail|
                  prisonerproperty = jail.find_prisonerproperty
                  prisonerproperty.release
                end
              else
                prisonerproperty.locked_up_throws += 1
              end
            else
              @boardgame.pot.money_in(@boardgame.active_player.pay_money(50))
              jails.each do |jail|
                prisonerproperty = jail.find_prisonerproperty
                prisonerproperty.release
              end
            end
          # Actions when player is no prisoner
          else
            if @boardgame.settings.dice.double?
              prisonerproperty.last_changed = false
              prisonerproperty.double_throws += 1
              if prisonerproperty.double_throws == 3
                prisonerproperty.last_changed = true
                prisonerproperty.lock_up
                @boardgame.active_player.position = @boardgame.gameboard.space_index(self)
              end
            else
              jails.each do |jail|
                prisonerproperty = jail.find_prisonerproperty
                prisonerproperty.double_throws = 0
              end
            end
          end
          @prisonerproperties.each do |p|
            p.last_changed = false if prisonerproperty != p
          end
        end
      end

      def find_prisonerproperty
        @prisonerproperties.each do |prisonerproperty|
          return prisonerproperty if prisonerproperty.player == @boardgame.active_player
        end
      end

      def to_jail
        player = find_prisonerproperty
        player.lock_up
        @boardgame.active_player.position = @boardgame.gameboard.space_index(self)
      end

    end
  end
end