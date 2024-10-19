require_relative '../objects/objects'
require_relative '../ast/ast'
require_relative '../environment/environment'

class Evaluator
  def initialize(env = Environment.new)
    @env = env
  end

  def evaluate(node)
    case node
    when AssignmentNode
      evaluate_assignment(node)
    when IdentifierNode
      @env.get(node.name)
    when NumberNode
      ForgeNumber.new(node.value)
    when ExpressionNode
      evaluate_expression(node)
    else
      raise "Unknown node: #{node.class}"
    end
  end

  def evaluate_assignment(node)
    value = evaluate(node.value) # Avalia o lado direito da atribuição
    @env.set(node.identifier.name, value) # Define o valor no ambiente
    value # Retorna o valor atribuído
  end

  def evaluate_expression(node)
    left = evaluate(node.left)
    right = evaluate(node.right)
    case node.operator.value
    when '+'
      left + right
    when '-'
      left - right
    when '*'
      left * right
    when '/'
      left / right
    else
      raise "Unknown operator: #{node.operator.value}"
    end
  end

  def truthy?(value)
    !value.is_a?(ForgeNull) && value.value != false && value.value != 0
  end
end
