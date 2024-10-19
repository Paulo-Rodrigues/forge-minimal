describe Forge::Lexer::Token do
  context 'KEYWORDS' do
    it 'list language keywords' do
      expect(Forge::Lexer::Token::KEYWORDS).to match({ VAR: 'var' })
    end
  end

  context 'OPERATORS' do
    it 'list language operators' do
      expect(Forge::Lexer::Token::OPERATORS).to match(
        {
          ASSIGN: '=',
          PLUS: '+',
          MINUS: '-',
          MULTIPLY: '*',
          DIVIDE: '/'
        }
      )
    end
  end

  context 'IDENTIFIERS' do
    it 'list of identifiers' do
      expect(Forge::Lexer::Token::IDENTIFIERS).to match(
        {
          IDENTIFIER: 'IDENTIFIER'
        }
      )
    end
  end

  context 'LITERALS' do
    it 'list of literals' do
      expect(Forge::Lexer::Token::LITERALS).to match({ INTEGER: 'INTEGER' })
    end
  end

  context 'DELIMITERS' do
    it 'list of delimeters' do
      expect(Forge::Lexer::Token::DELIMETERS).to match(
        {
          SEMICOLUMN: ';',
          COMMA: ',',
          LPAREN: '(',
          RPAREN: ')'
        }
      )
    end
  end

  context 'COMMONS' do
    it 'list of common globals' do
      expect(Forge::Lexer::Token::COMMONS).to match(
        {
          ILLEGAL: 'ILLEGAL',
          EOF: 'EOF'
        }
      )
    end
  end
end
