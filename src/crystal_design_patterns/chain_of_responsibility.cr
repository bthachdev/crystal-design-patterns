# https://en.wikipedia.org/wiki/Chain-of-responsibility_pattern

enum LogLevel
  None,
  Info,
  Debug,
  Warning,
  Error,
  FunctionalMessage,
  FunctionalError,
  All
end

abstract class Logger
  protected getter log_levels
  protected getter next : Logger | Nil

  def initialize(*levels)
    @log_levels = [] of LogLevel

    levels.each do |level|
      @log_levels << level
    end
  end

  def set_next(next_logger : Logger)
    @next = next_logger
  end

  def message(msg : String, severity : LogLevel)
    write_message(msg) if @log_levels.includes?(LogLevel::All) || @log_levels.includes?(severity)
    @next.try(&.message(msg, severity)) if @next
  end

  abstract def write_message(msg : String)
end

class ConsoleLogger < Logger
  def write_message(msg : String)
    puts "Writing to console: #{msg}"
  end
end

class EmailLogger < Logger
  def write_message(msg : String)
    puts "Sending via email: #{msg}"
  end
end

class FileLogger < Logger
  def write_message(msg : String)
    puts "Writing to Log File: #{msg}"
  end
end

# Program
# Build the chain of responsibility
logger = ConsoleLogger.new(LogLevel::All)
logger1 = logger.set_next(EmailLogger.new(LogLevel::FunctionalMessage, LogLevel::FunctionalError))
logger2 = logger1.set_next(FileLogger.new(LogLevel::Warning, LogLevel::Error))

# Handled by ConsoleLogger since the console has a loglevel of all
logger.message("Entering function ProcessOrder().", LogLevel::Debug)
logger.message("Order record retrieved.", LogLevel::Info)

# Handled by ConsoleLogger and FileLogger since filelogger implements Warning & Error
logger.message("Customer Address details missing in Branch DataBase.", LogLevel::Warning)
logger.message("Customer Address details missing in Organization DataBase.", LogLevel::Error)

# Handled by ConsoleLogger and EmailLogger as it implements functional error
logger.message("Unable to Process Order ORD1 Dated D1 For Customer C1.", LogLevel::FunctionalError)

# Handled by ConsoleLogger and EmailLogger
logger.message("Order Dispatched.", LogLevel::FunctionalMessage)
