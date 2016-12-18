# https://en.wikipedia.org/wiki/Command_pattern

abstract class Command
  abstract def execute
end

# The invoker class
class Switch
  getter history

  def initialize
    @history = [] of Command
  end

  def store_and_execute(command : Command)
    @history << command
    command.execute
  end
end

# The receiver class
class Light
  def on
    puts "The light is on"
  end

  def off
    puts "The light is off"
  end
end

# The command for turning on the light
class FlipUpCommand < Command
  private getter light : Light

  def initialize(@light)
  end

  def execute
    light.on
  end
end

# The command for turning off the light
class FlipDownCommand < Command
  private getter light : Light

  def initialize(@light)
  end

  def execute
    light.off
  end
end

# Program
lamp = Light.new
switch_up = FlipUpCommand.new(lamp)
switch_down = FlipDownCommand.new(lamp)

switch = Switch.new
switch.store_and_execute(switch_up)
switch.store_and_execute(switch_down)

p switch.history
