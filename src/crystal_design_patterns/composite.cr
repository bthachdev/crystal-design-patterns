# https://en.wikipedia.org/wiki/Composite_pattern

abstract class Graphic
  abstract def print
end

# Composite
class CompositeGraphic < Graphic
  private getter graphics

  def initialize
    @graphics = [] of Graphic
  end

  def print
    @graphics.each do |graphic|
      graphic.print
    end
  end

  def add(graphic : Graphic)
    @graphics.push(graphic)
  end

  def remove(graphic : Graphic)
    @graphics.delete(graphic)
  end
end

# Leaf
class Ellipse < Graphic
  private getter name : String

  def initialize(@name)
  end

  def print
    puts "Ellipse #{name}"
  end
end

class Program
  def initialize
    ellipse1 = Ellipse.new("1")
    ellipse2 = Ellipse.new("2")
    ellipse3 = Ellipse.new("3")
    ellipse4 = Ellipse.new("4")

    graphic = CompositeGraphic.new
    graphic1 = CompositeGraphic.new
    graphic2 = CompositeGraphic.new

    # graphic 1 contains 3 ellipses
    graphic1.add(ellipse1)
    graphic1.add(ellipse2)
    graphic1.add(ellipse3)

    # graphic 2 contains 1 ellipse
    graphic2.add(ellipse4)

    # graphic contains both graphic 1 and graphic 2
    graphic.add(graphic1)
    graphic.add(graphic2)

    # now print the graphic
    graphic.print
  end
end

Program.new
