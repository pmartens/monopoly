#require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

# Er bestaat een veld 'gevangenis'. Deze kan 0 [uitdaging!], 1 of meerdere malen voorkomen op het bord.
# Er bestaat een veld 'ga naar gevangenis'. Deze 0, 1 of meerdere malen voorkomen op het bord.
# Indien een speler op het veld 'ga naar gevangenis' landt, dan verplaatst de pion van deze speler naar het veld 'gevangenis'. De speler heeft dan de status 'gevangen'
# Als een speler driemaal achtereen 'dubbel' gooit, dan verplaatst de pion van deze speler naar 'gevangenis'. De speler heeft dan de status 'gevangen'
# Een speler met de status 'gevangen' mag twee beurten proberen om uit de gevangenis te komen door dubbel te gooien. Aan het begin van de derde beurt sinds gevangenschap moet deze speler $50 betalen aan de pot en komt daarmee vrij.
# Belangrijk: Probeer de regels rondom gevangenschap zoveel mogelijk binnen de vakjes (niet binnen de standaard spelregels, zoals de Monopoly class) na te leven. Indien het niet lukt om alles binnen de vakjes te doen, licht dan in maximaal 100 woorden toe waarom dat niet lukt met dat deel van de regels.
# Unit tests


describe "Fase 4: Criminelen en andere boeven" do
  before do
    players = []
    player1 = Monopoly::Player.new("player1")
    player1.pay_money(1501)
    players << player1
    player2 = Monopoly::Player.new("player2")
    players << player2
    settings = Monopoly::Settings.new(players)
    @monopoly = Monopoly::Monopoly.new(settings)
  end

  it "Er kan een vakje gevangenis worden aangeaakt" do
    jail = Monopoly::Space::Yail.new(@monopoly)

  end

  it "Er kan een vakje 'ga naar de gevaningenis' worden aangemaakt" do
    gotojail = Monopoly::Space::GoToYail.new(@monopoly)
    gotojail.
  end

end



