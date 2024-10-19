require_relative '../../lib/parser/parser'
require_relative '../../lib/ast/ast'

RSpec.describe Forge::Parser::Parser do
  context 'when parsing assignments' do
    let(:tokens_simple_assignment) do
      [
        { type: :VAR, value: 'var' },
        { type: :IDENTIFIER, value: 'counter123' },
        { type: :ASSIGN, value: '=' },
        { type: :INTEGER, value: '45' },
        { type: :SEMICOLUMN, value: ';' },
        { type: :EOF, value: '' }
      ]
    end

    it 'creates an AssignmentNode with an IdentifierNode and a NumberNode' do
      parser = described_class.new(tokens_simple_assignment)
      ast = parser.parse

      expect(ast.length).to eq(1)
      assignment_node = ast.first
      expect(assignment_node).to be_a(AssignmentNode)

      expect(assignment_node.identifier).to be_a(IdentifierNode)
      expect(assignment_node.identifier.name).to eq('counter123')

      expect(assignment_node.value).to be_a(NumberNode)
      expect(assignment_node.value.value).to eq('45')
    end

    let(:tokens_identifier_assignment) do
      [
        { type: :VAR, value: 'var' },
        { type: :IDENTIFIER, value: 'x' },
        { type: :ASSIGN, value: '=' },
        { type: :IDENTIFIER, value: 'y' },
        { type: :SEMICOLUMN, value: ';' },
        { type: :EOF, value: '' }
      ]
    end

    it 'creates an AssignmentNode with an IdentifierNode and another IdentifierNode' do
      parser = described_class.new(tokens_identifier_assignment)
      ast = parser.parse

      expect(ast.length).to eq(1)
      assignment_node = ast.first
      expect(assignment_node).to be_a(AssignmentNode)

      expect(assignment_node.identifier).to be_a(IdentifierNode)
      expect(assignment_node.identifier.name).to eq('x')

      expect(assignment_node.value).to be_a(IdentifierNode)
      expect(assignment_node.value.name).to eq('y')
    end
  end

  context 'when parsing complex expressions' do
    let(:tokens_expression_assignment) do
      [
        { type: :VAR, value: 'var' },
        { type: :IDENTIFIER, value: 'result' },
        { type: :ASSIGN, value: '=' },
        { type: :INTEGER, value: '10' },
        { type: :PLUS, value: '+' },
        { type: :INTEGER, value: '5' },
        { type: :SEMICOLUMN, value: ';' },
        { type: :EOF, value: '' }
      ]
    end

    it 'parses an assignment with a complex expression (10 + 5)' do
      parser = described_class.new(tokens_expression_assignment)
      ast = parser.parse

      expect(ast.length).to eq(1)
      assignment_node = ast.first
      expect(assignment_node).to be_a(AssignmentNode)

      expect(assignment_node.identifier).to be_a(IdentifierNode)
      expect(assignment_node.identifier.name).to eq('result')

      expect(assignment_node.value).to be_a(ExpressionNode)
      expect(assignment_node.value.left).to be_a(NumberNode)
      expect(assignment_node.value.left.value).to eq('10')

      expect(assignment_node.value.operator).to be_a(OperatorNode)
      expect(assignment_node.value.operator.value).to eq('+')

      expect(assignment_node.value.right).to be_a(NumberNode)
      expect(assignment_node.value.right.value).to eq('5')
    end
  end

  context 'when encountering invalid tokens' do
    let(:tokens_invalid) do
      [
        { type: :VAR, value: 'var' },
        { type: :IDENTIFIER, value: 'counter123' },
        { type: :ASSIGN, value: '=' },
        { type: :INTEGER, value: '45' },
        { type: :ILLEGAL, value: '@' },
        { type: :SEMICOLUMN, value: ';' },
        { type: :EOF, value: '' }
      ]
    end

    it 'raises an error when encountering an invalid token' do
      parser = described_class.new(tokens_invalid)

      expect do
        parser.parse
      end.to raise_error(RuntimeError, 'Unexpected token in expression: {:type=>:ILLEGAL, :value=>"@"}')
    end
  end

  context 'when encountering unexpected token types' do
    let(:tokens_unexpected_token) do
      [
        { type: :VAR, value: 'var' },
        { type: :INTEGER, value: '10' },
        { type: :ASSIGN, value: '=' },
        { type: :INTEGER, value: '45' },
        { type: :SEMICOLUMN, value: ';' },
        { type: :EOF, value: '' }
      ]
    end

    it 'raises an error when encountering an unexpected token type' do
      parser = described_class.new(tokens_unexpected_token)

      expect { parser.parse }.to raise_error(RuntimeError, 'Expected IDENTIFIER, but got: INTEGER')
    end
  end

  context 'when parsing complex expressions' do
    let(:tokens_expression_assignment) do
      [
        { type: :VAR, value: 'var' },
        { type: :IDENTIFIER, value: 'result' },
        { type: :ASSIGN, value: '=' },
        { type: :INTEGER, value: '10' },
        { type: :PLUS, value: '+' },
        { type: :INTEGER, value: '5' },
        { type: :SEMICOLUMN, value: ';' },
        { type: :EOF, value: '' }
      ]
    end

    it 'parses an assignment with a complex expression (10 + 5)' do
      parser = described_class.new(tokens_expression_assignment)
      ast = parser.parse

      expect(ast.length).to eq(1)
      assignment_node = ast.first
      expect(assignment_node).to be_a(AssignmentNode)

      expect(assignment_node.identifier).to be_a(IdentifierNode)
      expect(assignment_node.identifier.name).to eq('result')

      expect(assignment_node.value).to be_a(ExpressionNode)
      expect(assignment_node.value.left).to be_a(NumberNode)
      expect(assignment_node.value.left.value).to eq('10')

      expect(assignment_node.value.operator).to be_a(OperatorNode)
      expect(assignment_node.value.operator.value).to eq('+')

      expect(assignment_node.value.right).to be_a(NumberNode)
      expect(assignment_node.value.right.value).to eq('5')
    end
  end

  context 'when parsing multiple assignments' do
    let(:tokens_multiple_assignments) do
      [
        { type: :VAR, value: 'var' },
        { type: :IDENTIFIER, value: 'x' },
        { type: :ASSIGN, value: '=' },
        { type: :INTEGER, value: '5' },
        { type: :SEMICOLUMN, value: ';' },
        { type: :VAR, value: 'var' },
        { type: :IDENTIFIER, value: 'y' },
        { type: :ASSIGN, value: '=' },
        { type: :INTEGER, value: '10' },
        { type: :SEMICOLUMN, value: ';' },
        { type: :EOF, value: '' }
      ]
    end

    it 'parses multiple assignment statements correctly' do
      parser = described_class.new(tokens_multiple_assignments)
      ast = parser.parse

      expect(ast.length).to eq(2)
      assignment_node_1 = ast[0]
      assignment_node_2 = ast[1]

      expect(assignment_node_1).to be_a(AssignmentNode)
      expect(assignment_node_1.identifier).to be_a(IdentifierNode)
      expect(assignment_node_1.identifier.name).to eq('x')
      expect(assignment_node_1.value).to be_a(NumberNode)
      expect(assignment_node_1.value.value).to eq('5')

      expect(assignment_node_2).to be_a(AssignmentNode)
      expect(assignment_node_2.identifier).to be_a(IdentifierNode)
      expect(assignment_node_2.identifier.name).to eq('y')
      expect(assignment_node_2.value).to be_a(NumberNode)
      expect(assignment_node_2.value.value).to eq('10')
    end
  end
end
