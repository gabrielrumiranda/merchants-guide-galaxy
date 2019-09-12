# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'InputRepository' do
  describe '.read' do
    context 'when the given file is not empty' do
      subject(:read_lines) { InputRepository.new('spec/files_spec/test2.txt').read }

      it 'return include (glob is I)' do
        expect(read_lines[0]).to eq 'glob is I'
      end

      it 'return include (prok is V)' do
        expect(read_lines[1]).to eq 'prok is V'
      end

      it 'return need have exactly 2 items' do
        expect(read_lines).to have_exactly(2).file_lines
      end
    end

    context 'when the given file is empty' do
      subject(:read_lines) { InputRepository.new('spec/files_spec/test3.txt').read }

      it 'return need be empty' do
        expect(read_lines).to be_empty
      end

      it 'return need have exactly 0 items' do
        expect(read_lines).to have_exactly(0).file_lines
      end
    end

    context 'when the given file not exist' do
      subject(:read_lines) { InputRepository.new('spec/files_spec/test3.txt').read }

      it 'return need be empty' do
        expect(read_lines).to be_empty
      end

      it 'return need have exactly 0 items' do
        expect(read_lines).to have_exactly(0).file_lines
      end
    end
  end
end
