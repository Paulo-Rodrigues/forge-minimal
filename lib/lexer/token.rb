module Forge
  module Lexer
    module Token
      KEYWORDS = {
        VAR: 'var'
      }.freeze

      OPERATORS = {
        ASSIGN: '=',
        PLUS: '+',
        MINUS: '-',
        MULTIPLY: '*',
        DIVIDE: '/'
      }.freeze

      IDENTIFIERS = {
        IDENTIFIER: 'IDENTIFIER'
      }.freeze

      LITERALS = {
        INTEGER: 'INTEGER'
      }.freeze

      DELIMETERS = {
        SEMICOLUMN: ';',
        COMMA: ',',
        LPAREN: '(',
        RPAREN: ')'
      }.freeze

      COMMONS = {
        ILLEGAL: 'ILLEGAL',
        EOF: 'EOF'
      }.freeze
    end
  end
end
