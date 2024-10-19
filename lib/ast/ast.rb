class Node
end

class AssignmentNode < Node
  attr_reader :identifier, :value

  def initialize(identifier, value)
    super()
    @identifier = identifier
    @value = value
  end
end

class IdentifierNode < Node
  attr_reader :name

  def initialize(name)
    super()
    @name = name
  end
end

class ExpressionNode < Node
  attr_reader :left, :operator, :right

  def initialize(left, operator, right)
    super()
    @left = left
    @operator = operator
    @right = right
  end
end

class NumberNode < Node
  attr_reader :value

  def initialize(value)
    super()
    @value = value
  end
end

class SemicolumnNode < Node
end

class VarNode < Node
end

class CommaNode < Node
end

class OperatorNode < Node
  attr_reader :value

  def initialize(value)
    super()
    @value = value
  end
end

class EOFNode < Node
end
