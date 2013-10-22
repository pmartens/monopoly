class TraditionalDie < Die

  def faces
    faces = []
    (1..6).each do |i|
      faces << Face.new(i.to_s, i)
    end
    faces
  end

end