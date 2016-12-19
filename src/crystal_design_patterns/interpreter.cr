# https://en.wikipedia.org/wiki/Interpreter_pattern

# Example using Reverse Polish notation
# 5 + ((1 + 2) × 4) − 3
# can be written down like this
# 5 1 2 + 4 x + 3 -

abstract class Expression
  abstract def interpret(variables : Hash(String, Expression)) : Int32
end

class NumberExpr < Expression
  private getter number : Int32

  def initialize(@number)
  end

  def interpret(variables : Hash(String, Expression)) : Int32
    @number
  end
end

class PlusExpr < Expression
  getter left_operand : Expression
  getter right_operand : Expression

  def initialize(@left_operand, @right_operand)
  end

  def interpret(variables : Hash(String, Expression)) : Int32
    left_operand.interpret(variables) + right_operand.interpret(variables)
  end
end

class MinusExpr < Expression
  getter left_operand : Expression
  getter right_operand : Expression

  def initialize(@left_operand, @right_operand)
  end

  def interpret(variables : Hash(String, Expression)) : Int32
    left_operand.interpret(variables) - right_operand.interpret(variables)
  end
end

class VariableExpr < Expression
  getter name : String

  def initialize(@name)
  end

  def interpret(variables : Hash(String, Expression)) : Int32
    return variables[@name].interpret(variables) if variables[@name]?
    return 0
  end
end

# Parse expression
class Evaluator < Expression
  private getter syntax_tree : Expression

  def initialize(expression_str : String)
    expressions = [] of Expression

    expression_str.split(" ").each do |token|
      case token
      when "+"
        sub_expression = PlusExpr.new(expressions.pop, expressions.pop)
        expressions << sub_expression
      when "-"
        right = expressions.pop
        left = expressions.pop
        sub_expression = MinusExpr.new(left, right)
        expressions << sub_expression
      else
        expressions << VariableExpr.new(token)
      end
    end

    # syntax tree
    @syntax_tree = expressions.pop
  end

  def interpret(context : Hash(String, Expression)) : Int32
    @syntax_tree.interpret(context)
  end
end

# Program
expression_str = "w x z - +"
sentence = Evaluator.new(expression_str) # parse expression string

variables = {} of String => Expression
variables["w"] = NumberExpr.new(5)
variables["x"] = NumberExpr.new(10)
variables["z"] = NumberExpr.new(42)

puts "Result: #{sentence.interpret(variables)}"

# "5 10 42 - +"
# Step 1. push 5 onto stack => Stack: 5
# Step 2. push 10 onto stack => Stack: 10 5
# Step 3. push 42 onto stack => Stack: 42 10 5
# Step 4. - operator, pop the two operands (42, 10), calculate 10 - 42 = -32 and push onto stack => Stack: -32 5
# Step 5. + operator, pop the two operaand (-32, 5), calculate 5 + (-32) = -27 and push onto stack => Stack: -27
# Result: -27
