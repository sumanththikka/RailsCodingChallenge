require "vertex"
class Cuboid

  attr_accessor :origin, :length, :width, :height
  alias :x :length
  alias :y :width
  alias :z :height
  
  #BEGIN public methods that should be your starting point

  # Assuming there's no other data, changing just the origin of the cuboid
  def move_to!(x, y, z)
    origin.x = x
    origin.y = y
    origin.z = z
  end
  
  def vertices   
  	[
	  Vertex.new(origin.x, origin.y, origin.z),
	  Vertex.new((origin.x + length), origin.y, origin.z),
	  Vertex.new((origin.x + length), (origin.y + width), origin.z),
	  Vertex.new((origin.x + length), (origin.y + width), (origin.z + height)),
	  Vertex.new(origin.x, (origin.y + width), origin.z),
	  Vertex.new(origin.x, (origin.y + width), (origin.z + height)),
	  Vertex.new(origin.x, origin.y, (origin.z + height)),
	  Vertex.new((origin.x + length), origin.y, (origin.z + height))
	]
  end
  
  #returns true if the two cuboids intersect each other.  False otherwise.
  def intersects?(other_cuboid)
  	(other_cuboid.origin.x < (origin.x + length)) && ((other_cuboid.origin.x + other_cuboid.length) > origin.x) &&
		(other_cuboid.origin.y < (origin.y + width)) && ((other_cuboid.origin.y + other_cuboid.width) > origin.y) &&
		(other_cuboid.origin.z < (origin.z + height)) && ((other_cuboid.origin.z + other_cuboid.height) > origin.z)
  end

  # Rotates the cuboid along specified axis in specified direction
  # Direction can be 'clockwise': away from (0,0,0) and 'anti_clockwise': towards (0,0,0)
  # Assumption, no other cuboids in clockwise direction
  def rotate!(axis, direction)
  	return false unless ['clock', 'anti_clock'].include?(direction.to_s) and ['x', 'y', 'z'].include?(axis.to_s.downcase)
  	direction_indicator = direction == 'clock' ? 1 : -1
  	changed_coordinate = origin.send(axis) + (direction_indicator * send(axis))
  	return false if changed_coordinate < 0
  	origin.send("#{axis}=", changed_coordinate)
  	return true
  end
  #END public methods that should be your starting point  
end

