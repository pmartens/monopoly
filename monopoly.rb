$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end

# require 'benchmark'
# require 'pry'
# require 'pry-nav'
# require 'pry-stack_explorer'

require 'game'

players = []

puts "How many players? :"
player_amount = gets.to_i

for i in 1..player_amount
  puts "Enter name for player#{i}:"
  players << Monopoly::Player.new(gets.chomp.to_s)
end

settings = Monopoly::Settings.new(players)

monopoly = Monopoly::Monopoly.new(settings)

while !monopoly.winner do
  puts "======================================================="
  puts "Player #{monopoly.active_player.name} may throw."
  puts "PRESS ENTER"
  if gets == "\n"
    puts "Current position: #{monopoly.gameboard.space(monopoly.active_player.position).name}"
    puts "Throw Dice !"
    monopoly.throw_dice
    puts "Score #{monopoly.settings.dice.value.to_s}"

    monopoly.settings.players.each do |p|
      puts "Player: #{p.name} Position: #{monopoly.gameboard.space(p.position).name}"
    end
  end
  puts "======================================================="
end