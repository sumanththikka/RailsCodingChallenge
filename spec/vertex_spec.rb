require 'vertex'

describe Vertex do
 
  describe "vetex initialisation" do
    it "it initialises the vetex with given co-ordinates" do
    	vertex = Vertex.new(1,2,3)
      expect(vertex.x).to eq(1)
      expect(vertex.y).to eq(2)
      expect(vertex.z).to eq(3)
    end

    it "it initialises the vetex with default 0 for all co-ordinates" do
    	vertex = Vertex.new
      expect(vertex.x).to eq(0)
      expect(vertex.y).to eq(0)
      expect(vertex.z).to eq(0)
    end
  end  

end  