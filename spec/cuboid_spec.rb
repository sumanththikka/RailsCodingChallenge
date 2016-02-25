require 'cuboid'
require 'vertex'

#This test is incomplete and, in fact, won't even run without errors.  
#  Do whatever you need to do to make it work and please add your own test cases for as many
#  methods as you feel need coverage
describe Cuboid do
 
  describe "move_to" do
    it "changes the origin in the simple happy case" do
    	cuboid = Cuboid.new()
		  cuboid.origin = Vertex.new(0,0,0)
			cuboid.length = 5
			cuboid.width = 3
			cuboid.height = 4
			cuboid.move_to!(1,2,3)
      expect(cuboid.origin.x).to eq(1)
      expect(cuboid.origin.y).to eq(2)
      expect(cuboid.origin.z).to eq(3)
    end
  end  

  describe "vertices" do
  	before :each do
		  @cuboid = Cuboid.new()
		  @cuboid.origin = Vertex.new(0,0,0)
			@cuboid.length = 5
			@cuboid.width = 3
			@cuboid.height = 4
		end
  	it "returns an array" do
			expect(@cuboid.vertices).to be_a Array
  	end

  	it "returns an array of 8 elements" do
  		expect(@cuboid.vertices.length).to eq(8)
  	end
  	
  	it "returns an array of Vertex objects" do
  		expect(@cuboid.vertices.first).to be_an_instance_of Vertex
  	end
  end

  describe "rotate!" do
  	before :each do
		  @cuboid = Cuboid.new()
		  @cuboid.origin = Vertex.new(0,0,0)
			@cuboid.length = 5
			@cuboid.width = 3
			@cuboid.height = 4
		end
  	it "rotates clockwise" do
			expect(@cuboid.rotate!('x', 'clock')).to be true
  	end

  	it "rotates clockwise" do
			expect(@cuboid.rotate!('y', 'clock')).to be true
  	end

  	it "rotates clockwise" do
			expect(@cuboid.rotate!('z', 'clock')).to be true
  	end

  	it " can't rotate anti-clockwise" do
  		expect(@cuboid.rotate!('x', 'anti_clock')).to be false
  	end
  	
  	describe "can't rotate with invalid inputs" do 
  		before :each do
			  @cuboid = Cuboid.new()
			  @cuboid.origin = Vertex.new(0,0,0)
				@cuboid.length = 5
				@cuboid.width = 3
				@cuboid.height = 4
			end

  		it " can't rotate with invalid axis" do
				expect(@cuboid.rotate!('xsa', 'anti_clock')).to be false
			end

			it " can't rotate with invalid direction" do
				expect(@cuboid.rotate!('x', 'santi_clocks')).to be false
			end
  	end
  	
  end
  
  describe "intersects?" do
  	
  	describe "if origin of the second cuboid is inside first" do
  		before :each do
			  @cuboid_1 = Cuboid.new()
			  @cuboid_1.origin = Vertex.new(0,0,0)
				@cuboid_1.length = 5
				@cuboid_1.width = 3
				@cuboid_1.height = 4
			end
  		it "it returns true when second is smaller than first" do
  			cuboid_2 = Cuboid.new()
  			cuboid_2.origin = Vertex.new(1,1,1)
				cuboid_2.length = 1
				cuboid_2.width = 1
				cuboid_2.height = 1
				expect(@cuboid_1.intersects?(cuboid_2)).to be true
  		end

  		it "it returns true when second is equal or bigger than first" do
  			cuboid_2 = Cuboid.new()
  			cuboid_2.origin = Vertex.new(1,1,1)
				cuboid_2.length = 5
				cuboid_2.width = 4
				cuboid_2.height = 4
				expect(@cuboid_1.intersects?(cuboid_2)).to be true
  		end
  		it "it returns false when second origin is outside first and not intersecting" do
  			cuboid_2 = Cuboid.new()
  			cuboid_2.origin = Vertex.new(6,6,6)
				cuboid_2.length = 2
				cuboid_2.width = 2
				cuboid_2.height = 2
				expect(@cuboid_1.intersects?(cuboid_2)).to be false
  		end
  	end

  	describe "if origin of the first is farther than the second" do
  		before :each do
			  @cuboid_1 = Cuboid.new()
			  @cuboid_1.origin = Vertex.new(5,5,5)
				@cuboid_1.length = 5
				@cuboid_1.width = 3
				@cuboid_1.height = 4
			end
  		it "it returns true when second origin is outside first" do
  			cuboid_2 = Cuboid.new()
  			cuboid_2.origin = Vertex.new(4,2,3)
				cuboid_2.length = 4
				cuboid_2.width = 4
				cuboid_2.height = 5
				expect(@cuboid_1.intersects?(cuboid_2)).to be true
  		end

  		it "it returns true when second origin is outside first" do
  			cuboid_2 = Cuboid.new()
  			cuboid_2.origin = Vertex.new(5,6,6)
				cuboid_2.length = 5
				cuboid_2.width = 4
				cuboid_2.height = 4
				expect(@cuboid_1.intersects?(cuboid_2)).to be true
  		end

  		it "it returns false when second origin is outside first and not intersecting" do
  			cuboid_2 = Cuboid.new()
  			cuboid_2.origin = Vertex.new(0,0,0)
				cuboid_2.length = 2
				cuboid_2.width = 2
				cuboid_2.height = 2
				expect(@cuboid_1.intersects?(cuboid_2)).to be false
  		end

  	end

  	describe "when two cuboids are adjacent" do
  		before :each do
			  @cuboid_1 = Cuboid.new()
			  @cuboid_1.origin = Vertex.new(0,0,0)
				@cuboid_1.length = 5
				@cuboid_1.width = 5
				@cuboid_1.height = 4
			end
			it "returns false when vertical surfaces are next to each other" do
				cuboid_2 = Cuboid.new()
  			cuboid_2.origin = Vertex.new(5,0,0)
				cuboid_2.length = 2
				cuboid_2.width = 2
				cuboid_2.height = 2
				expect(@cuboid_1.intersects?(cuboid_2)).to be false
			end

			it "returns false when horizantal surfaces are next to each other" do
				cuboid_2 = Cuboid.new()
  			cuboid_2.origin = Vertex.new(0,5,0)
				cuboid_2.length = 2
				cuboid_2.width = 2
				cuboid_2.height = 2
				expect(@cuboid_1.intersects?(cuboid_2)).to be false
			end

			it "returns false when cuboids are aliged along depth" do
				cuboid_2 = Cuboid.new()
  			cuboid_2.origin = Vertex.new(0,0,4)
				cuboid_2.length = 2
				cuboid_2.width = 2
				cuboid_2.height = 2
				expect(@cuboid_1.intersects?(cuboid_2)).to be false
			end

		end

  end

end
