# https://en.wikipedia.org/wiki/Lazy_initialization

class Fruit
  private getter type : String
  @@types = {} of String => Fruit

  def initialize(@type)
  end

  def self.get_fruit_by_type(type : String)
    @@types[type] ||= Fruit.new(type)
  end

  def self.show_all
    puts "Number of instances made: #{@@types.size}"
    @@types.each do |type, fruit|
      puts "#{type}"
    end
    puts
  end

  def self.size
    @@types.size
  end
end

# Fruit.get_fruit_by_type("Banana")
# Fruit.show_all

# Fruit.get_fruit_by_type("Apple")
# Fruit.show_all

# Fruit.get_fruit_by_type("Banana")
# Fruit.show_all
