# https://en.wikipedia.org/wiki/Proxy_pattern

abstract class AbstractCar
  abstract def drive
end

class Car < AbstractCar
  def drive
    puts "Car has been driven!"
  end
end

class Driver
  getter age : Int32

  def initialize(@age)
  end
end

class ProxyCar < AbstractCar
  private getter driver : Driver
  private getter real_car : AbstractCar

  def initialize(@driver)
    @real_car = Car.new
  end

  def drive
    if driver.age <= 16
      puts "Sorry, the driver is too young to drive."
    else
      @real_car.drive
    end
  end
end

# Program
driver = Driver.new(16)
car = ProxyCar.new(driver)
car.drive

driver = Driver.new(25)
car = ProxyCar.new(driver)
car.drive
