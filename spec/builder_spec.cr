require "./spec_helper"

describe Car do
  it "default car with 4 wheels, 4 seats and black color" do
    car = Car.new
    car.wheels.should eq(4)
    car.seats.should eq(4)
    car.color.should eq("Black")
  end
end

describe CarBuilder do
  describe "create car with 3 wheels, 2 seats and red color" do
    car_builder = CarBuilder.new
    car_builder.set_wheels(3)
    car_builder.set_seats(2)
    car_builder.set_color("Red")
    car = car_builder.get_result

    it "has 3 wheels" do
      car.wheels.should eq(3)
    end

    it "has 2 seats" do
      car.seats.should eq(2)
    end

    it "has Red color" do
      car.color.should eq("Red")
    end
  end
end
