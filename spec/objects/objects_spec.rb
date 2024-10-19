require_relative '../../lib/objects/objects'

RSpec.describe ForgeNumber do
  let(:num_10) { ForgeNumber.new(10) }
  let(:num_5) { ForgeNumber.new(5) }

  context 'when initializing a ForgeNumber' do
    it 'sets the value correctly' do
      expect(num_10.value).to eq(10)
      expect(num_5.value).to eq(5)
    end
  end

  context 'when performing arithmetic operations' do
    it 'adds two ForgeNumbers' do
      result = num_10 + num_5
      expect(result).to be_a(ForgeNumber)
      expect(result.value).to eq(15)
    end

    it 'subtracts two ForgeNumbers' do
      result = num_10 - num_5
      expect(result).to be_a(ForgeNumber)
      expect(result.value).to eq(5)
    end

    it 'multiplies two ForgeNumbers' do
      result = num_10 * num_5
      expect(result).to be_a(ForgeNumber)
      expect(result.value).to eq(50)
    end

    it 'divides two ForgeNumbers' do
      result = num_10 / num_5
      expect(result).to be_a(ForgeNumber)
      expect(result.value).to eq(2)
    end
  end

  context 'when converting to string' do
    it 'converts a ForgeNumber to a string' do
      expect(num_10.to_s).to eq('10')
      expect(num_5.to_s).to eq('5')
    end
  end
end
