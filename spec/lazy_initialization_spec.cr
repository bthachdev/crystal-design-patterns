require "../src/crystal_design_patterns/lazy_initialization"

describe Fruit do
  describe "Create an apple" do
    it "has 1 instance" do
      Fruit.get_fruit_by_type("Apple")
      Fruit.size.should eq(1)
    end
  end

  describe "Create another banana" do
    it "has 2 instances" do
      Fruit.get_fruit_by_type("Banana")
      Fruit.size.should eq(2)
    end
  end

  describe "Create another apple" do
    it "still has 2 instances" do
      Fruit.get_fruit_by_type("Apple")
      Fruit.size.should eq(2)
    end
  end
end
