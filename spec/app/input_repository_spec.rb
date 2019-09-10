require_relative '../spec_helper'

RSpec.describe 'InputRepository' do
  describe '.path' do
    context 'Set a valid path' do
      subject { InputRepository.new}

      it 'Returns an path' do
        subject.set_path('spec/files_spec/test.txt')
        expect(subject.path).to eq 'spec/files_spec/test.txt'
      end
    end

    context 'Set a invalid path' do
      subject { InputRepository.new('spec/app/test2.txt') }

      it 'Returns empty path' do
        subject.set_path('spec/app/test2.txt')
        expect(subject.path).to eq ''
      end
    end
  end
  describe '.read' do
    context 'Set a file not empty' do
      subject { InputRepository.new }

      it 'Returns a array with all read lines' do
        subject.set_path('spec/files_spec/test2.txt')
        subject.read
        puts subject.file_lines
        expect(subject.file_lines[0]).to eq "glob is I\n"
        expect(subject.file_lines[1]).to eq "prok is V\n"
        expect(subject).to have_exactly(2).file_lines 
      end
    end
  end
end
