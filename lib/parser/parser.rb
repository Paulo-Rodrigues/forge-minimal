module Forge
  module Parser
    class Parser
      attr_reader :tokens, :current_token

      def initialize(tokens)
        @tokens = tokens
        @current_token_index = 0
        @current_token = tokens[0]
      end

      def parse
        statements = []
        until end_of_tokens?
          break if current_token[:type] == :EOF
          statements << parse_statement
        end
        statements
      end

      private

      def parse_statement
        case current_token[:type]
        when :VAR
          parse_variable_declaration
        when :IDENTIFIER
          if peek_token[:type] == :ASSIGN
            parse_assignment_without_var
          else
            parse_expression_statement
          end
        else
          raise "Unexpected token: #{current_token}"
        end
      end

      def peek_token
        return nil if @current_token_index + 1 >= tokens.length
        tokens[@current_token_index + 1]
      end

      def parse_variable_declaration
        consume(:VAR)
        identifier_token = consume(:IDENTIFIER)
        identifier_node = IdentifierNode.new(identifier_token[:value])

        consume(:ASSIGN)
        expression_node = parse_expression

        consume(:SEMICOLUMN)

        AssignmentNode.new(identifier_node, expression_node)
      end

      def parse_assignment_without_var
        identifier_token = consume(:IDENTIFIER)
        identifier_node = IdentifierNode.new(identifier_token[:value])

        consume(:ASSIGN)
        expression_node = parse_expression

        consume(:SEMICOLUMN)

        AssignmentNode.new(identifier_node, expression_node)
      end

      def parse_assignment
        consume(:VAR)
        identifier_token = consume(:IDENTIFIER)
        identifier_node = IdentifierNode.new(identifier_token[:value])

        consume(:ASSIGN)
        expression_node = parse_expression

        consume(:SEMICOLUMN)

        AssignmentNode.new(identifier_node, expression_node)
      end

      def parse_expression_statement
        expression_node = parse_expression
        consume(:SEMICOLUMN)
        expression_node
      end

      def parse_expression
        left = parse_primary_expression

        while operator?(current_token)
          operator_token = consume(current_token[:type])
          operator_node = OperatorNode.new(operator_token[:value])

          right = parse_primary_expression
          left = ExpressionNode.new(left, operator_node, right)
        end

        left
      end

      def parse_primary_expression
        case current_token[:type]
        when :INTEGER
          value_token = consume(:INTEGER)
          NumberNode.new(value_token[:value])
        when :IDENTIFIER
          identifier_token = consume(:IDENTIFIER)
          IdentifierNode.new(identifier_token[:value])
        else
          raise "Unexpected token in expression: #{current_token}"
        end
      end

      def operator?(token)
        %i[PLUS MINUS MULTIPLY DIVIDE].include?(token[:type])
      end

      def consume(expected_type)
        if current_token[:type] == :ILLEGAL
          raise "Unexpected token in expression: #{current_token}"
        elsif current_token[:type] == expected_type
          token = current_token
          advance
          token
        else
          raise "Expected #{expected_type}, but got: #{current_token[:type]}"
        end
      end

      def advance
        @current_token_index += 1 unless end_of_tokens?
        @current_token = tokens[@current_token_index] unless end_of_tokens?
      end

      def end_of_tokens?
        @current_token_index >= tokens.length
      end
    end
  end
end
