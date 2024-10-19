require_relative 'token'

module Forge
  module Lexer
    class Tokenizer
      include Forge::Lexer::Token

      attr_reader :tokens

      def initialize(program)
        @program = program.strip
        @tokens = []
        @position = 0
      end

      def tokenize
        until end_of_program?
          ignore_whitespace

          if delimiter?(current_char)
            add_token(delimiter_type(current_char), current_char)
            advance
            next
          end

          if operator_start?(current_char)
            operator = read_operator
            add_token(operator_type(operator), operator)
            next
          end

          if digit?(current_char)
            literal = read_number
            add_token(:INTEGER, literal)
            next
          end

          if letter?(current_char)
            identifier = read_identifier
            if keyword?(identifier)
              add_token(keyword_type(identifier), identifier)
            else
              add_token(:IDENTIFIER, identifier)
            end
            next
          end

          add_token(:ILLEGAL, current_char)
          advance
        end

        add_token(:EOF, '')
        tokens
      end

      private

      attr_accessor :position, :program

      def current_char
        program[position]
      end

      def advance
        @position += 1
      end

      def end_of_program?
        position >= @program.length
      end

      def add_token(type, value)
        tokens << { type: type, value: value }
      end

      def whitespace?(char)
        char =~ /\s/
      end

      def delimiter?(char)
        DELIMETERS.values.include?(char)
      end

      def delimiter_type(char)
        DELIMETERS.key(char)
      end

      def operator_start?(char)
        OPERATORS.values.any? { |op| op.start_with?(char) }
      end

      def read_operator
        start_pos = position

        unless end_of_program?
          advance if operator_start?(current_char) && operator_start?(peek_char)
          advance
        end

        program[start_pos...position]
      end

      def peek_char
        return nil if position + 1 >= program.length

        program[position + 1]
      end

      def operator_type(operator)
        OPERATORS.key(operator)
      end

      def digit?(char)
        char =~ /\d/
      end

      def read_number
        start_pos = position
        advance while !end_of_program? && digit?(current_char)
        program[start_pos...position]
      end

      def letter?(char)
        char =~ /[a-zA-Z_]/
      end

      def read_identifier
        start_pos = position
        advance while !end_of_program? && (letter?(current_char) || digit?(current_char))
        program[start_pos...position]
      end

      def keyword?(identifier)
        KEYWORDS.values.include?(identifier)
      end

      def keyword_type(keyword)
        KEYWORDS.key(keyword)
      end

      def ignore_whitespace
        advance while !end_of_program? && whitespace?(current_char)
      end
    end
  end
end
