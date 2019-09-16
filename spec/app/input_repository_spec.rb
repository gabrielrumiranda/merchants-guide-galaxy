# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'InputRepository' do
  describe '.read' do
    context 'when the given file is not empty' do
      subject(:read_lines) { InputRepository.new('spec/files_spec/test2.txt').read }

      it 'read lines is equal [glob is I, prok is V])' do
        expect(read_lines).to eq ['glob is I', 'prok is V']
      end
    end

    context 'when the given file is empty' do
      subject(:read_lines) { InputRepository.new('spec/files_spec/test3.txt').read }

      it { is_expected.to be_empty }
    end

    context 'when the given file not exist' do
      subject(:read_lines) { InputRepository.new('spec/files_spec/test3.txt').read }

      it { is_expected.to be_empty }
    end
  end
end
