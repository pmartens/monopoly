#require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

# Er bestaat een veld 'gevangenis'. Deze kan 0 [uitdaging!], 1 of meerdere malen voorkomen op het bord.
# Er bestaat een veld 'ga naar gevangenis'. Deze 0, 1 of meerdere malen voorkomen op het bord.

# Indien een speler op het veld 'ga naar gevangenis' landt, dan verplaatst de pion van deze speler naar het veld 'gevangenis'. De speler heeft dan de status 'gevangen'
# Als een speler driemaal achtereen 'dubbel' gooit, dan verplaatst de pion van deze speler naar 'gevangenis'. De speler heeft dan de status 'gevangen'
# Een speler met de status 'gevangen' mag twee beurten proberen om uit de gevangenis te komen door dubbel te gooien. Aan het begin van de derde beurt sinds gevangenschap moet deze speler $50 betalen aan de pot en komt daarmee vrij.


# Belangrijk: Probeer de regels rondom gevangenschap zoveel mogelijk binnen de vakjes (niet binnen de standaard spelregels, zoals de Monopoly class) na te leven. Indien het niet lukt om alles binnen de vakjes te doen, licht dan in maximaal 100 woorden toe waarom dat niet lukt met dat deel van de regels.
# Unit tests


describe "Fase 4: Criminelen en andere boeven = " do
  before do
    players = []
    @player1 = Monopoly::Player.new("player1")
    players << @player1
    @player2 = Monopoly::Player.new("player2")
    players << @player2
    settings = Monopoly::Settings.new(players)
    @monopoly = Monopoly::Monopoly.new(settings)
  end

  it "1. Game:GameBoard.spaces(name): Wanneer twee gevangenis vakjes aanwezig zijn op het speelbord dan moet het aantal vakjes met de naam 'gevangenis' twee zijn." do
    jail1 = Monopoly::Space::Jail.new(@monopoly)
    jail2 = Monopoly::Space::Jail.new(@monopoly)
    gameboard = Game::GameBoard.new(@monopoly)
    gameboard.add_space(jail1)
    gameboard.add_space(jail2)
    jails = gameboard.spaces("Jail")
    jails.count.should eq(2)
  end

  it "2. Monopoly:Space:Jail.find_prisonerproperty.locked_up: Een speler heeft standaard niet de status 'gevangene'." do
    jail = Monopoly::Space::Jail.new(@monopoly)
    jail.find_prisonerproperty.locked_up.should be_false
  end

  it "3. Monopoly:Space:Jail.before_action(): Wanneer een speler met status 'gevangene', 1 maal de beurt heeft gehad dan moet het aantal speel beurten van deze speler op 1 staan waaneer er geen dubbel is gegooit." do
    jail = Monopoly::Space::Jail.new(@monopoly)
    jail.find_prisonerproperty.lock_up
    spaces = []
    spaces << jail
    allow(@monopoly.gameboard).to receive(:spaces) {spaces}
    allow(@monopoly.settings.dice).to receive(:double?) {false}
    jail.before_action
    jail.find_prisonerproperty.locked_up_throws.should eq(1)
  end

  it "4. Monopoly:Space:Jail.before_action(): Wanneer een speler 1 maal 'dubbel' gooit moet het aantal dubbele worpen van de speler op 1 staan." do
    jail = Monopoly::Space::Jail.new(@monopoly)
    jail.find_prisonerproperty.release
    spaces = []
    spaces << jail
    allow(@monopoly.gameboard).to receive(:spaces) {spaces}
    allow(@monopoly.settings.dice).to receive(:double?) {true}
    jail.before_action
    jail.find_prisonerproperty.double_throws.should eq(1)
  end

  it "5. Monopoly:Space:Jail.before_action(): Wanneer een speler na 2 dubbele worpen niet dubbel gooit moet het aantal dubbele worpen van de speler op 0 staan." do
    jail = Monopoly::Space::Jail.new(@monopoly)
    jail.find_prisonerproperty.release
    spaces = []
    spaces << jail
    allow(@monopoly.gameboard).to receive(:spaces) {spaces}
    allow(@monopoly.settings.dice).to receive(:double?) {true}
    jail.before_action
    jail.find_prisonerproperty.double_throws.should eq(1)
    jail.before_action
    jail.find_prisonerproperty.double_throws.should eq(2)
    allow(@monopoly.settings.dice).to receive(:double?) {false}
    jail.before_action
    jail.find_prisonerproperty.double_throws.should eq(0)
  end

  it "6. Monopoly:Space:Jail.before_action(): Als een speler driemaal achtereen 'dubbel' gooi heeft het de status 'gevangen' en mag zich niet verplaatsen." do
    jail = Monopoly::Space::Jail.new(@monopoly)
    jail.find_prisonerproperty.release
    spaces = []
    spaces << jail
    allow(@monopoly.gameboard).to receive(:spaces) {spaces}
    allow(@monopoly.settings.dice).to receive(:double?) {true}
    jail.before_action
    jail.player_can_move.should be_true
    jail.before_action
    jail.player_can_move.should be_true
    jail.before_action
    jail.player_can_move.should be_false
  end

  it "7. Monopoly:Space:Jail.before_action(): Als een speler driemaal achtereen 'dubbel' gooit moet de pion van de speler naar de 'gevangenis' worden verplaatst." do
    @player1.position = 0
    jail = @monopoly.gameboard.space(30)
    jail.find_prisonerproperty.release
    allow(@monopoly.settings.dice).to receive(:double?) {true}
    jail.before_action
    jail.before_action
    jail.before_action
    jail.player_can_move.should be_false
    @player1.position.should eq(30)
  end

  it "8. Monopoly:Space:Jail.before_action(): Een speler met de status 'gevangen' mag bij de eerste beurt dubbel gooien weer vrij zonder te betalen." do
    jail = Monopoly::Space::Jail.new(@monopoly)
    jail.find_prisonerproperty.lock_up
    allow(@monopoly.settings.dice).to receive(:double?) {true}
    jail.before_action
    @player1.money.should eq(1500)
    jail.player_can_move.should be_true
  end

  it "9. Monopoly:Space:Jail.before_action(): Een speler met de status 'gevangen' moet aan het begin van de derde beurt sinds gevangenschap $50 betalen aan de pot en komt weer vrij." do
    jail = Monopoly::Space::Jail.new(@monopoly)
    jail.find_prisonerproperty.lock_up
    spaces = []
    spaces << jail
    allow(@monopoly.gameboard).to receive(:spaces) {spaces}
    allow(@monopoly.settings.dice).to receive(:double?) {false}
    jail.before_action
    jail.find_prisonerproperty.last_changed = false
    jail.before_action
    jail.find_prisonerproperty.last_changed = false
    jail.before_action
    @player1.money.should eq(1450)
    @monopoly.pot.money.should eq(50)
  end

  it "10. Monopoly:Space:Jail.to_jail(): Wanneer vanuit een ander vakje de pion van de speler naar de gevangenis wordt verplaatst dan krijgt de speler de status 'gevangene' en de positie van de gevangenis." do
    @player1.position = 0
    jail = @monopoly.gameboard.space(30)
    jail.to_jail
    @player1.position.should eq(30)
  end

  it "11. Monopoly:Space:Jail.before_action(): Als een speler 1 maal 'dubbel' gooit en er zijn twee vakjes 'gevangenis', dan moet het aantal dubbele worpen van de speler op 1 staan." do
    @player1.position = 0
    jail1 = Monopoly::Space::Jail.new(@monopoly)
    jail2 = Monopoly::Space::Jail.new(@monopoly)
    spaces = []
    spaces << jail1
    spaces << jail2
    allow(@monopoly.gameboard).to receive(:spaces) {spaces}
    allow(@monopoly.settings.dice).to receive(:double?) {true}
    jail1.find_prisonerproperty.release
    jail1.before_action
    jail2.before_action
    jail1.find_prisonerproperty.double_throws.should eq(1)
    jail2.find_prisonerproperty.double_throws.should eq(1)
  end

  it "12. Monopoly:Space:Jail.before_action(): Als een speler driemaal achtereen 'dubbel' gooit en er zijn twee vakjes 'gevangenis', dan verplaatst de pion van de de speler naar de eerste vakje 'gevangenis'." do
    @player1.position = 0
    jail1 = Monopoly::Space::Jail.new(@monopoly)
    jail2 = Monopoly::Space::Jail.new(@monopoly)
    spaces = []
    spaces << jail1
    spaces << jail2
    allow(@monopoly.gameboard).to receive(:spaces) {spaces}
    allow(@monopoly.settings.dice).to receive(:double?) {true}
    jail1.find_prisonerproperty.release
    jail1.before_action
    jail2.before_action
    jail1.find_prisonerproperty.double_throws.should eq(1)
    jail1.before_action
    jail2.before_action
    jail1.find_prisonerproperty.double_throws.should eq(2)
    jail1.before_action
    jail2.before_action
    jail1.find_prisonerproperty.locked_up.should be_true
    jail1.player_can_move.should be_false
    @player1.position.should eq(@monopoly.gameboard.space_index(jail1))
  end

  # Space:GoToJail

  it "13. Space:GoToJail.land_action(): Wanneer een speler op het vakje 'ga naar de gevangenis' land dan verplaatst de pion van deze speler naar het veld 'gevangenis'." do
    @player1.position = 10
    gotojail = @monopoly.gameboard.spaces("go to jail").first
    jail =  @monopoly.gameboard.spaces("Jail").first
    gotojail.land_action
    @player1.position.should eq(@monopoly.gameboard.space_index(jail))
  end

end



