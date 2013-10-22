class Die
  
  attr_accessor :faces

  @@die_counter = 0

  def initialize
    @@die_counter += 1
  end

  def count
    @@die_counter  
  end

end