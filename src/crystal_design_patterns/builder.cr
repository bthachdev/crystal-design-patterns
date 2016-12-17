# https://en.wikipedia.org/wiki/Builder_pattern

class Car
  property wheels : Int32
  property seats : Int32
  property color : String

  def initialize(@wheels = 4, @seats = 4, @color = "Black")
  end
end

abstract class Builder
  abstract def set_wheels(number : Int32)
  abstract def set_seats(number : Int32)
  abstract def set_color(color : String)
  abstract def get_result
end

class CarBuilder < Builder
  private getter car : Car

  def initialize
    @car = Car.new
  end

  def set_wheels(value : Int32)
    @car.wheels = value
  end

  def set_seats(value : Int32)
    @car.seats = value
  end

  def set_color(value : String)
    @car.color = value
  end

  def get_result
    return @car
  end
end

class CarBuilderDirector
  def self.construct : Car
    builder = CarBuilder.new
    builder.set_wheels(8)
    builder.set_seats(4)
    builder.set_color("Red")
    builder.get_result
  end
end

# Run program
car = CarBuilderDirector.construct
p car
