# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe Calculator do
  let(:repository) { InputRepository.new(path) }
  let(:calculator) { described_class.new(repository: repository) }

  describe '#calculate!' do
    subject(:calculate) { calculator.calculate! }

    context 'when the path is invalid' do
      let(:path) { 'spec/files_spec/invalid.txt' }

      it { is_expected.to be_empty }
    end

    context 'when the path is valid' do
      let(:path) { 'spec/files_spec/test2.txt' }

      it 'returns parsed lines' do
        expect(calculate).to eq(['-', '-'])
      end
    end

    context 'when the file is empty' do
      let(:path) { 'spec/files_spec/test3.txt' }

      it { is_expected.to be_empty }
    end
  end
end
