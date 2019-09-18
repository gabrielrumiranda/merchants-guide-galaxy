# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe Calculator do
  let(:repository) { InputRepository.new(path) }

  describe '#calculate!' do
    subject(:calculator) do
      described_class.new(repository: repository).calculate!
      
    end

    context 'when the path is invalid' do
      let(:path) { 'spec/files_spec/invalid.txt' }

      it { is_expected.to be_empty }
    end

    context 'when the path is valid' do
      let(:path) { 'spec/files_spec/test2.txt' }

      it 'returns parsed lines' do
        expect(calculator).to eq(['-', '-'])
      end
    end

    context 'when the file is empty' do
      let(:path) { 'spec/files_spec/test3.txt' }

      it { is_expected.to be_empty }
    end
  end
end
