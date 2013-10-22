class Turn
  attr_accessor :dice

  @score = []

  def initialize (dice)
    @dice = dice
    reset
  end
  
  def reset
    @turns = 0
  end
  
  def next(player)
    @player = player
  end
  
  def player
    @player
  end
  
  def dice_throw
    @score = []
    @dice.each do |die|
      @score << { die => die.faces.sample.value }
    end
    @score.each{ |data| data.each{ |key, value| puts "Die score: #{value}"}}
    puts "Total Dice score: #{dice_score.to_s}"
  end
  
  def dice_score
    score = 0
    @score.each{ |data| data.each{ |key, value| score += value}}
    score
  end
  
  def score_for_each_die(die)
    score = 0
    @score.each do |data| 
      data.each do |key, value| 
        if key == die
          score = value 
        end
      end
    end
    score
  end 
    
  def move_position
    puts "Move to new position: #{dice_score.to_i}"
    dice_score.to_i
  end
  
  def double_dice
    score = []
    @score.each{ |data| data.each{ |key, value| score.concat([value])}}
    if score.uniq.count == 1
      puts "** D O U B L E D I C E **"
      true
    else
      false
    end
  end
  
end