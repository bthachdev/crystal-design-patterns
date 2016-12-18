# https://en.wikipedia.org/wiki/Flyweight_pattern

# Instances of CoffeeFlavor will be the Flyweights
class CoffeeFlavor
  def initialize(new_flavor : String)
    @name = new_flavor
  end

  def to_s(io)
    io << @name
  end
end

# Menu acts as a factory and cache for CoffeeFlavor flyweight objects
class Menu
  def initialize
    @flavors = {} of String => CoffeeFlavor
  end

  def lookup(flavor_name : String)
    @flavors[flavor_name] ||= CoffeeFlavor.new(flavor_name)
  end

  def total_flavors_made
    @flavors.size
  end
end

# Order is the context of the CoffeeFlavor flyweight.
class Order
  private getter table_number : Int32, flavor : CoffeeFlavor

  def initialize(@table_number, @flavor)
  end

  def serve
    puts "Serving #{flavor} to table #{table_number}"
  end
end

class CoffeeShop
  private getter orders
  private getter menu

  def initialize
    @orders = [] of Order
    @menu = Menu.new
  end

  def take_order(flavor_name : String, table : Int32)
    flavor = menu.lookup(flavor_name)
    order = Order.new(table, flavor)
    @orders << order
  end

  def service
    orders.each do |order|
      order.serve
    end
  end

  def report
    "Total CoffeeFlavor made: #{menu.total_flavors_made}"
  end
end

# Program
shop = CoffeeShop.new
shop.take_order("Cappuchino", 2)
shop.take_order("Frappe", 1)
shop.take_order("Espresso", 1)
shop.take_order("Frappe", 897)
shop.take_order("Cappuccino", 97)
shop.take_order("Frappe", 3)
shop.take_order("Espresso", 3)
shop.take_order("Cappuccino", 3)
shop.take_order("Espresso", 96)
shop.take_order("Frappe", 552)
shop.take_order("Cappuccino", 121)
shop.take_order("Espresso", 121)

shop.service
puts shop.report
