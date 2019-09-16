# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'InputRepository' do
  describe '.read' do
    subject(:read_lines) { InputRepository.new(path).read }

    context 'when the given file is not empty' do
      let(:path) { 'spec/files_spec/test2.txt' }

      it 'read lines is equal [glob is I, prok is V])' do
        expect(read_lines).to eq ['glob is I', 'prok is V']
      end
    end

    context 'when the given file is empty' do
      let(:path) { 'spec/files_spec/test3.txt' }

      it { is_expected.to be_empty }
    end

    context 'when the given file not exist' do
      let(:path) { 'spec/files_spec/test4.txt' }

      it { is_expected.to be_empty }
    end
  end
end
