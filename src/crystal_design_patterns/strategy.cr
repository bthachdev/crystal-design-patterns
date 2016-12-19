# https://en.wikipedia.org/wiki/Strategy_pattern

class Customer
  property strategy : BillingStrategy
  getter drinks

  def initialize(@strategy)
    @drinks = [] of Float64
  end

  def add(price, quantity)
    @drinks << @strategy.get_price(price * quantity)
  end

  def print_bill
    sum = @drinks.sum
    puts "Total due: #{sum}"
    @drinks.clear
  end
end

abstract class BillingStrategy
  abstract def get_price(raw_price)
end

class NormalStrategy < BillingStrategy
  def get_price(raw_price)
    raw_price
  end
end

class HappyHourStrategy < BillingStrategy
  def get_price(raw_price)
    raw_price * 0.5
  end
end

# Program
first_customer = Customer.new(NormalStrategy.new)
first_customer.add(1.0, 1) # normal billing

# Start Happy Hour
first_customer.strategy = HappyHourStrategy.new
first_customer.add(1.0, 2)
first_customer.print_bill

# New customer
second_customer = Customer.new(HappyHourStrategy.new)
second_customer.add(0.8, 1)

# End Happy Hour
second_customer.strategy = NormalStrategy.new
second_customer.add(1.3, 2)
second_customer.add(2.5, 1)
second_customer.print_bill
