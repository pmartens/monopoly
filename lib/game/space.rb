class Space
  attr_accessor :id
  attr_accessor :name
  
  @@space_counter = 0

  def initialize(name)
    raise "Space name empty!" unless !name.empty?
    @@space_counter += 1
    @id = @@space_counter
    @name = name
  end
  
  def count
    @@space_counter
  end
  
end