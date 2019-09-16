# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'Calculator' do
  let!(:repository) { InputRepository.new(path) }

  describe '.calculate!' do
    context 'when the path is invalid' do
      let(:path) { 'spec/files_spec/invalid.txt' }
      subject(:calculator) { Calculator.new(repository: repository).calculate! }

      it { should be_empty }
    end

    context 'when the path is valid' do
      let(:path) { 'spec/files_spec/test2.txt' }
      subject(:calculator) { Calculator.new(repository: repository).calculate! }

      it 'Parsed lines is equal ["-", "-"]' do
        expect(calculator).to eq(['-', '-'])
      end
    end

    context 'when the file is empty' do
      let(:path) { 'spec/files_spec/test3.txt' }
      subject(:calculator) { Calculator.new(repository: repository).calculate! }

      it 'Parsed lines is empty' do
        expect(calculator).to be_empty
      end
    end
  end
end
