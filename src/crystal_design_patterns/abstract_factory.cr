# https://en.wikipedia.org/wiki/Abstract_factory_pattern

abstract class Button
  abstract def paint
end

class LinuxButton < Button
  def paint
    "Render a button in a Linux style"
  end
end

class WindowsButton < Button
  def paint
    "Render a button in a Windows style"
  end
end

class MacOSButton < Button
  def paint
    "Render a button in a MacOS style"
  end
end

abstract class GUIFactory
  abstract def create_button : Button
end

class LinuxFactory < GUIFactory
  def create_button
    return LinuxButton.new
  end
end

class WindowsFactory < GUIFactory
  def create_button
    return WindowsButton.new
  end
end

class MacOSFactory < GUIFactory
  def create_button
    return MacOSButton.new
  end
end

# Run program
appearance = "linux"

case appearance
when "linux"
  factory = LinuxFactory.new
when "osx"
  factory = MacOSFactory.new
when "win"
  factory = WindowsFactory.new
end

if factory
  button = factory.create_button
  result = button.paint
  puts result
end
