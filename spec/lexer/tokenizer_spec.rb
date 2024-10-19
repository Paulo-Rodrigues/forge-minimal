describe Forge::Lexer::Tokenizer do
  context 'first program tokens' do
    let(:program) { 'var x = 2;' }

    it 'return corresponding tokens' do
      tokens = described_class.new(program).tokenize
      expect(tokens).to match(
        [
          { type: :VAR, value: 'var' },
          { type: :IDENTIFIER, value: 'x' },
          { type: :ASSIGN, value: '=' },
          { type: :INTEGER, value: '2' },
          { type: :SEMICOLUMN, value: ';' },
          { type: :EOF, value: '' }
        ]
      )
    end
  end

  context 'with operators' do
    let(:program) { 'x = 10 + 20 / 2 * 3 - 1' }

    it 'returns corresponding tokens for operators' do
      tokens = described_class.new(program).tokenize
      expect(tokens).to match(
        [
          { type: :IDENTIFIER, value: 'x' },
          { type: :ASSIGN, value: '=' },
          { type: :INTEGER, value: '10' },
          { type: :PLUS, value: '+' },
          { type: :INTEGER, value: '20' },
          { type: :DIVIDE, value: '/' },
          { type: :INTEGER, value: '2' },
          { type: :MULTIPLY, value: '*' },
          { type: :INTEGER, value: '3' },
          { type: :MINUS, value: '-' },
          { type: :INTEGER, value: '1' },
          { type: :EOF, value: '' }
        ]
      )
    end
  end

  context 'with a program containing illegal characters' do
    let(:program) { 'var x = 10 @ y;' }

    it 'returns an illegal token for unrecognized characters' do
      tokens = described_class.new(program).tokenize
      expect(tokens).to match(
        [
          { type: :VAR, value: 'var' },
          { type: :IDENTIFIER, value: 'x' },
          { type: :ASSIGN, value: '=' },
          { type: :INTEGER, value: '10' },
          { type: :ILLEGAL, value: '@' },
          { type: :IDENTIFIER, value: 'y' },
          { type: :SEMICOLUMN, value: ';' },
          { type: :EOF, value: '' }
        ]
      )
    end
  end

  context 'identifiers and numbers' do
    let(:program) { 'var counter123 = 45;' }

    it 'returns tokens with identifiers and numbers' do
      tokens = described_class.new(program).tokenize
      expect(tokens).to match(
        [
          { type: :VAR, value: 'var' },
          { type: :IDENTIFIER, value: 'counter123' },
          { type: :ASSIGN, value: '=' },
          { type: :INTEGER, value: '45' },
          { type: :SEMICOLUMN, value: ';' },
          { type: :EOF, value: '' }
        ]
      )
    end
  end

  context 'delimiters and operators' do
    let(:program) { 'x = 5, y = 10;' }

    it 'returns corresponding tokens for mixed delimiters and operators' do
      tokens = described_class.new(program).tokenize
      expect(tokens).to match(
        [
          { type: :IDENTIFIER, value: 'x' },
          { type: :ASSIGN, value: '=' },
          { type: :INTEGER, value: '5' },
          { type: :COMMA, value: ',' },
          { type: :IDENTIFIER, value: 'y' },
          { type: :ASSIGN, value: '=' },
          { type: :INTEGER, value: '10' },
          { type: :SEMICOLUMN, value: ';' },
          { type: :EOF, value: '' }
        ]
      )
    end
  end

  context 'with an empty program' do
    let(:program) { '' }

    it 'returns only the EOF token for an empty program' do
      tokens = described_class.new(program).tokenize
      expect(tokens).to match(
        [
          { type: :EOF, value: '' }
        ]
      )
    end
  end
end
