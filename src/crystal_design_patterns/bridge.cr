# https://en.wikipedia.org/wiki/Bridge_pattern

abstract class DrawingAPI
  abstract def draw_circle(x : Float64, y : Float64, radius : Float64)
end

class DrawingAPI1 < DrawingAPI
  def draw_circle(x : Float, y : Float, radius : Float)
    "API1.circle at #{x}:#{y} - radius: #{radius}"
  end
end

class DrawingAPI2 < DrawingAPI
  def draw_circle(x : Float64, y : Float64, radius : Float64)
    "API2.circle at #{x}:#{y} - radius: #{radius}"
  end
end

abstract class Shape
  protected getter drawing_api : DrawingAPI

  def initialize(@drawing_api)
  end

  abstract def draw
  abstract def resize_by_percentage(percent : Float64)
end

class CircleShape < Shape
  getter x : Float64
  getter y : Float64
  getter radius : Float64

  def initialize(@x, @y, @radius, drawing_api : DrawingAPI)
    super(drawing_api)
  end

  def draw
    @drawing_api.draw_circle(@x, @y, @radius)
  end

  def resize_by_percentage(percent : Float64)
    @radius *= (1 + percent/100)
  end
end

class BridgePattern
  def self.test
    shapes = [] of Shape
    shapes << CircleShape.new(1.0, 2.0, 3.0, DrawingAPI1.new)
    shapes << CircleShape.new(5.0, 7.0, 11.0, DrawingAPI2.new)

    shapes.each do |shape|
      shape.resize_by_percentage(2.5)
      puts shape.draw
    end
  end
end

BridgePattern.test
