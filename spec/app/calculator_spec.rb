require_relative '../spec_helper'

RSpec.describe 'Calculator' do
  let!(:repository) { InputRepository.new(path) }

  describe '.calculate!' do
    context 'when the path is invalid' do
      let(:path) { 'spec/files_spec/invalid.txt' }
      subject(:calculator) { Calculator.new(repository: repository) }

      it 'Parsed lines is empty' do
        calculator.calculate!
        expect(calculator.parsed_lines).to be_empty
      end
    end

    context 'when the path is valid' do
      let(:path) { 'spec/files_spec/test2.txt' }
      subject(:calculator) { Calculator.new(repository: repository) }

      it 'Parsed lines is equal ["-", "-"]' do
        calculator.calculate!
        expect(calculator.parsed_lines).to eq(['-', '-'])
      end
    end

    context 'when the file is empty' do
      let(:path) { 'spec/files_spec/test3.txt' }
      subject(:calculator) { Calculator.new(repository: repository) }

      it 'Parsed lines is empty' do
        calculator.calculate!
        expect(calculator.parsed_lines).to be_empty
      end
    end
  end
end