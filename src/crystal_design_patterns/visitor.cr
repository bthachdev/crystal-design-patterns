# https://en.wikipedia.org/wiki/Visitor_pattern

abstract class CarElementVisitor
  abstract def visit(wheel : Wheel)
  abstract def visit(engine : Engine)
  abstract def visit(body : Body)
  abstract def visit(car : Car)
end

abstract class CarElement
  abstract def accept(vistor : CarElementVisitor)
end

class Wheel < CarElement
  getter name : String

  def initialize(@name)
  end

  def accept(vistor : CarElementVisitor)
    vistor.visit(self)
  end
end

class Engine < CarElement
  def accept(vistor : CarElementVisitor)
    vistor.visit(self)
  end
end

class Body < CarElement
  def accept(vistor : CarElementVisitor)
    vistor.visit(self)
  end
end

class Car < CarElement
  getter elements

  def initialize
    @elements = [] of CarElement
    @elements = [
      Wheel.new("front left"),
      Wheel.new("front right"),
      Wheel.new("back left"),
      Wheel.new("back right"),
      Body.new,
      Engine.new,
    ]
  end

  def accept(vistor : CarElementVisitor)
    @elements.each do |element|
      element.accept(vistor)
    end
    vistor.visit(self)
  end
end

class CarElementPrintVisitor < CarElementVisitor
  def visit(wheel : Wheel)
    puts "Visiting #{wheel.name} wheel"
  end

  def visit(engine : Engine)
    puts "Visiting engine"
  end

  def visit(body : Body)
    puts "Visiting body"
  end

  def visit(car : Car)
    puts "Visiting car"
  end
end

class CarElementDoVisitor < CarElementVisitor
  def visit(wheel : Wheel)
    puts "Kicking my #{wheel.name} wheel"
  end

  def visit(engine : Engine)
    puts "Starting my engine"
  end

  def visit(body : Body)
    puts "Moving my body"
  end

  def visit(car : Car)
    puts "Starting my car"
  end
end

# Program
car = Car.new
car.accept(CarElementPrintVisitor.new)
car.accept(CarElementDoVisitor.new)

# Output
# Visiting front left wheel
# Visiting front right wheel
# Visiting back left wheel
# Visiting back right wheel
# Visiting body
# Visiting engine
# Visiting car
# Kicking my front left wheel
# Kicking my front right wheel
# Kicking my back left wheel
# Kicking my back right wheel
# Moving my body
# Starting my engine
# Starting my car
