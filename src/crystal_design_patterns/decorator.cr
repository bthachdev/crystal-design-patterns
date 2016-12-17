# https://en.wikipedia.org/wiki/Decorator_pattern

abstract class Coffee
  abstract def cost
  abstract def ingredients
end

# Extension of a simple coffee
class SimpleCoffee < Coffee
  def cost
    1.0
  end

  def ingredients
    "cofee"
  end
end

# Abstract decorator
class CoffeeDecorator < Coffee
  protected getter decorated_coffee : Coffee

  def initialize(@decorated_coffee)
  end

  def cost
    decorated_coffee.cost
  end

  def ingredients
    decorated_coffee.ingredients
  end
end

class WithMilk < CoffeeDecorator
  def cost
    super + 0.5
  end

  def ingredients
    super + ", Milk"
  end
end

class WithSprinkles < CoffeeDecorator
  def cost
    super + 0.2
  end

  def ingredients
    super + ", Sprinkles"
  end
end

class Program
  def print(coffee : Coffee)
    puts "Cost: #{coffee.cost}; Ingredients: #{coffee.ingredients}"
  end

  def initialize
    coffee = SimpleCoffee.new
    print(coffee)

    coffee = WithMilk.new(coffee)
    print(coffee)

    coffee = WithSprinkles.new(coffee)
    print(coffee)
  end
end

Program.new
