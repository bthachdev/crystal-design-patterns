# https://en.wikipedia.org/wiki/Facade_pattern

BOOT_ADDRESS = 7004000400
BOOT_SECTOR  =     0x7C00
SECTOR_SIZE  =       4096

class CPU
  def freeze
    puts "freeze cpu"
  end

  def jump(position)
    puts "jump to #{position}"
  end

  def execute
    puts "execute"
  end
end

class Memory
  def load(position, data)
    puts "load data: [#{data}] into position: #{position}"
  end
end

class HardDrive
  def read(lba, size)
    "lba: #{lba}, size: #{size}"
  end
end

class ComputerFacade
  def initialize
    @processor = CPU.new
    @ram = Memory.new
    @hd = HardDrive.new
  end

  def start
    @processor.freeze
    @ram.load(BOOT_ADDRESS, @hd.read(BOOT_SECTOR, SECTOR_SIZE))
    @processor.jump(BOOT_ADDRESS)
    @processor.execute
  end
end

# Client
computer_facade = ComputerFacade.new
computer_facade.start
