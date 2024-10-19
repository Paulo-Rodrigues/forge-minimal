require_relative '../lib/ast/ast'
require_relative '../lib/lexer/tokenizer'
require_relative '../lib/parser/parser'
require_relative '../lib/environment/environment'
require_relative '../lib/evaluator/evaluator'

Environment.new
evaluator = Evaluator.new

def repl(evaluator)
  loop do
    print '> '
    input = gets.chomp

    break if input == 'exit'

    input += ';' unless input.end_with?(';')

    begin
      tokens = Forge::Lexer::Tokenizer.new(input).tokenize
      parser = Forge::Parser::Parser.new(tokens)
      ast = parser.parse
      result = evaluator.evaluate(ast.first) unless ast.empty?

      puts "=> #{result}"
    rescue StandardError => e
      puts "Erro: #{e.message}"
    end
  end
end

repl(evaluator)
