# https://en.wikipedia.org/wiki/State_pattern

abstract class StateLike
  abstract def write_name(context : StateContext, name : String)
end

class StateContext
  property state : StateLike

  def initialize
    @state = StateLowerCase.new
  end

  def write_name(name : String)
    @state.write_name(self, name)
  end
end

class StateLowerCase < StateLike
  def write_name(context : StateContext, name : String)
    puts name.downcase
    context.state = StateMutipleUpperCase.new
  end
end

class StateMutipleUpperCase < StateLike
  getter count : Int32

  def initialize
    @count = 0
  end

  def write_name(context : StateContext, name : String)
    puts name.upcase
    @count = @count + 1
    context.state = StateLowerCase.new if @count > 1
  end
end

# program
sc = StateContext.new
sc.write_name("Monday")
sc.write_name("Tuesday")
sc.write_name("Wednesday")
sc.write_name("Thursday")
sc.write_name("Friday")
sc.write_name("Saturday")
sc.write_name("Sunday")

# Ouput
# monday
# TUESDAY
# WEDNESDAY
# thursday
# FRIDAY
# SATURDAY
# sunday
