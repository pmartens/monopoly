require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "Monopoly::Space::Jail - " do
  before do
    players = []
    (1..3).each do |i|
      players << Monopoly::Player.new("player#{i}")
    end
    settings = Monopoly::Settings.new(players)
    @monopoly = Monopoly::Monopoly.new(settings)
  end

  it "1. At start of the game all players are not prisoner" do
    jail = Monopoly::Space::Jail.new(@monopoly)
    allow(@monopoly).to receive(:active_player) {@monopoly.settings.players[0]}
    jail.prisonerproperty.locked_up.should be_false
    allow(@monopoly).to receive(:active_player) {@monopoly.settings.players[1]}
    jail.prisonerproperty.locked_up.should be_false
    allow(@monopoly).to receive(:active_player) {@monopoly.settings.players[2]}
    jail.prisonerproperty.locked_up.should be_false
  end

  it "2. When a player throws double for the first time the lockup trhow for this player is 1." do
    jail = Monopoly::Space::Jail.new(@monopoly)
    spaces = []
    spaces << jail
    allow(@monopoly.gameboard).to receive(:spaces) {spaces}
    allow(@monopoly.settings.dice).to receive(:double?) {true}
    jail.always_action
    jail.prisonerproperty.double_throws.should eq(1)
  end

  it "3. When a player throws two times double and the last throw is not double. The player double throws is 0." do
    jail = Monopoly::Space::Jail.new(@monopoly)
    spaces = []
    spaces << jail
    allow(@monopoly.gameboard).to receive(:spaces) {spaces}
    allow(@monopoly.settings.dice).to receive(:double?) {true}
    jail.always_action
    jail.prisonerproperty.double_throws.should eq(1)
    jail.always_action
    jail.prisonerproperty.double_throws.should eq(2)
    allow(@monopoly.settings.dice).to receive(:double?) {false}
    jail.always_action
    jail.prisonerproperty.double_throws.should eq(0)
  end

  it "4. When a player throws three times double the player is prisoner" do
    jail = Monopoly::Space::Jail.new(@monopoly)
    spaces = []
    spaces << jail
    allow(@monopoly.gameboard).to receive(:spaces) {spaces}
    allow(@monopoly.settings.dice).to receive(:double?) {true}
    jail.always_action
    jail.start_action.should be_true
    jail.always_action
    jail.start_action.should be_true
    jail.always_action
    jail.start_action.should be_false
  end

  it "5. When a player is prisoner and the player played one turn, the locked up throws should be 1." do
    jail = Monopoly::Space::Jail.new(@monopoly)
    spaces = []
    spaces << jail
    allow(@monopoly.gameboard).to receive(:spaces) {spaces}
    allow(@monopoly.settings.dice).to receive(:double?) {false}
    allow(jail.prisonerproperty).to receive(:locked_up) {true}
    jail.always_action
    jail.start_action
    jail.prisonerproperty.locked_up_throws.should eq(1)
  end

  it "6. When a player is prisoner and at the first turn the player throws double the player is free without paying" do
    jail = Monopoly::Space::Jail.new(@monopoly)
    spaces = []
    spaces << jail
    allow(@monopoly.gameboard).to receive(:spaces) {spaces}
    allow(@monopoly.settings.dice).to receive(:double?) {true}
    jail.prisonerproperty.locked_up = true
    jail.always_action
    jail.start_action.should be_true
    @monopoly.settings.players[0].money.should eq(1500)
  end

  it "7. When a player is prisoner and at the third turn he doesn't throw double. He must pay $50 to the pot an he is free." do
    jail = Monopoly::Space::Jail.new(@monopoly)
    spaces = []
    spaces << jail
    allow(@monopoly.gameboard).to receive(:spaces) {spaces}
    allow(@monopoly.settings.dice).to receive(:double?) {false}
    jail.prisonerproperty.locked_up = true
    jail.prisonerproperty.locked_up_throws = 2
    jail.always_action
    jail.start_action.should be_true
    @monopoly.settings.players[0].money.should eq(1450)
    @monopoly.pot.money.should eq(50)
  end

  it "8. WHen a player moves from an other space to jail, the player becomes prisoner" do
    jail = @monopoly.gameboard.space(30)
    jail.to_jail
    @monopoly.settings.players[0].position.should eq(30)
  end


end



