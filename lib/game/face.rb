class Face
  attr_accessor :name
  attr_accessor :value

  @@face_counter = 0

  def initialize(name, value)
    @@face_counter += 1
    @name = name
    @value = value
  end

  def counter
    @@face_counter 
  end
  
end