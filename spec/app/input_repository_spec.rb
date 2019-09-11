require_relative '../spec_helper'

RSpec.describe 'InputRepository' do
  describe '.read' do
    context 'Set a file not empty' do
      subject(:read_lines) { InputRepository.new('spec/files_spec/test2.txt').read }

      it 'return include (glob is I\n)' do
        expect(read_lines[0]).to eq "glob is I\n"
      end

      it 'return include (prok is V\n)' do
        expect(read_lines[1]).to eq "prok is V\n"
      end

      it 'return need have exactly 2 items' do
        expect(read_lines).to have_exactly(2).file_lines
      end
    end
  end
end
