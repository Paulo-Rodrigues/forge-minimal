require_relative '../../lib/ast/ast'

describe Node do
  it 'can be instantiated' do
    expect(Node.new).to be_a(Node)
  end
end

describe AssignmentNode do
  it 'can be instantiated with an identifier and a value' do
    identifier = IdentifierNode.new('counter123')
    value = NumberNode.new(45)
    assignment_node = AssignmentNode.new(identifier, value)

    expect(assignment_node).to be_a(AssignmentNode)
    expect(assignment_node.identifier).to eq(identifier)
    expect(assignment_node.value).to eq(value)
  end
end

describe IdentifierNode do
  it 'can be instantiated with a name' do
    identifier_node = IdentifierNode.new('counter123')

    expect(identifier_node).to be_a(IdentifierNode)
    expect(identifier_node.name).to eq('counter123')
  end
end

describe ExpressionNode do
  it 'can be instantiated with left expression, operator, and right expression' do
    left_node = IdentifierNode.new('counter123')
    right_node = NumberNode.new(45)
    operator_node = OperatorNode.new('+')
    expression_node = ExpressionNode.new(left_node, operator_node, right_node)

    expect(expression_node).to be_a(ExpressionNode)
    expect(expression_node.left).to eq(left_node)
    expect(expression_node.operator).to eq(operator_node)
    expect(expression_node.right).to eq(right_node)
  end
end

describe NumberNode do
  it 'can be instantiated with a value' do
    number_node = NumberNode.new(45)

    expect(number_node).to be_a(NumberNode)
    expect(number_node.value).to eq(45)
  end
end

describe SemicolumnNode do
  it 'can be instantiated' do
    semicolumn_node = SemicolumnNode.new

    expect(semicolumn_node).to be_a(SemicolumnNode)
  end
end

describe VarNode do
  it 'can be instantiated' do
    var_node = VarNode.new

    expect(var_node).to be_a(VarNode)
  end
end

describe CommaNode do
  it 'can be instantiated' do
    comma_node = CommaNode.new

    expect(comma_node).to be_a(CommaNode)
  end
end

describe OperatorNode do
  it 'can be instantiated with a value' do
    operator_node = OperatorNode.new('+')

    expect(operator_node).to be_a(OperatorNode)
    expect(operator_node.value).to eq('+')
  end
end

describe EOFNode do
  it 'can be instantiated' do
    eof_node = EOFNode.new

    expect(eof_node).to be_a(EOFNode)
  end
end
