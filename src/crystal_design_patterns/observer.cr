# https://en.wikipedia.org/wiki/Observer_pattern

class Observable
  getter observers

  def initialize
    @observers = [] of Observer
  end

  def register_observer(observer : Observer)
    @observers << observer
  end

  def notify_observers(*args)
    @observers.each do |observer|
      observer.notify(args)
    end
  end
end

class Observer
  getter name : String

  def initialize(@name)
  end

  def subscribe(observable)
    observable.register_observer(self)
  end

  def notify(args)
    puts "notify #{@name}: #{args}"
  end
end

# program
subject = Observable.new
observer1 = Observer.new("observer 1")
observer1.subscribe(subject)

observer2 = Observer.new("observer 2")
observer2.subscribe(subject)

subject.notify_observers("test1", "test2")
