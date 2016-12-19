# https://en.wikipedia.org/wiki/Memento_pattern

class Originator
  private getter state : String

  def initialize
    @state = ""
  end

  def set(state : String)
    puts "Setting state to #{state}"
    @state = state
  end

  def save_to_memento : Memento
    puts "Saving #{@state} to Memento"
    Memento.new(@state)
  end

  def restore_from_memento(memento : Memento)
    @state = memento.get_saved_state
    puts "State after restoring from Memento: #{@state}"
  end
end

class Memento
  private getter state : String

  def initialize(state_to_save)
    @state = state_to_save
  end

  def get_saved_state
    @state
  end
end

# Program
saved_states = [] of Memento

originator = Originator.new
originator.set("State1")
originator.set("State2")

puts
saved_states << originator.save_to_memento
originator.set("State3")

puts
saved_states << originator.save_to_memento
originator.set("State4")

originator.restore_from_memento(saved_states.last)
