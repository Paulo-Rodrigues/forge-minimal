require_relative '../../lib/objects/objects'
require_relative '../../lib/evaluator/evaluator'
require_relative '../../lib/ast/ast'
require_relative '../../lib/environment/environment'

describe Evaluator do
  let(:evaluator) { described_class.new }

  context 'when evaluating numbers' do
    it 'evaluates a NumberNode' do
      number_node = NumberNode.new(10)
      result = evaluator.evaluate(number_node)

      expect(result).to be_a(ForgeNumber)
      expect(result.value).to eq(10)
    end
  end

  context 'when evaluating assignments' do
    it 'evaluates an AssignmentNode' do
      identifier_node = IdentifierNode.new('x')
      number_node = NumberNode.new(10)

      assignment_node = AssignmentNode.new(identifier_node, number_node)

      result = evaluator.evaluate(assignment_node)

      expect(result).to be_a(ForgeNumber)
      expect(result.value).to eq(10)

      expect(evaluator.instance_variable_get(:@env).get('x').value).to eq(10)
    end
  end

  context 'when evaluating identifiers' do
    it 'retrieves the value of an identifier from the environment' do
      evaluator.instance_variable_get(:@env).set('x', ForgeNumber.new(20))

      identifier_node = IdentifierNode.new('x')

      result = evaluator.evaluate(identifier_node)

      expect(result).to be_a(ForgeNumber)
      expect(result.value).to eq(20)
    end
  end

  context 'when evaluating expressions' do
    it 'evaluates arithmetic expressions' do
      expression_node = ExpressionNode.new(NumberNode.new(10), OperatorNode.new('+'), NumberNode.new(5))
      result = evaluator.evaluate(expression_node)

      expect(result).to be_a(ForgeNumber)
      expect(result.value).to eq(15)
    end
  end

  context 'when evaluating unknown nodes' do
    it 'raises an error for unknown node types' do
      unknown_node = double('UnknownNode')

      expect { evaluator.evaluate(unknown_node) }.to raise_error(RuntimeError, 'Unknown node: RSpec::Mocks::Double')
    end
  end
end
