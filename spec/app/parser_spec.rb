require_relative '../spec_helper'

RSpec.describe 'Parser' do
  describe '.parse_roman_number' do
    context 'Parse a valid Line' do
      subject { Parser.new }

      it 'Returns a dictionary with new word' do
        tokens = 'glob is I'.split(' ')
        is_position = tokens.find_index('is')
        subject.parse_roman_number(tokens, is_position)
        expect(subject.dictionary.words).not_to be_empty
        expect(subject.dictionary.words).to include('glob' => 1)
        expect(subject.dictionary).to have_exactly(1).words
      end
    end

    context 'Parse a invalid Line' do
      subject { Parser.new }

      it 'Returns a empty dictionary' do
        tokens = 'asdsd asdasd is asdsd aasdsad'.split(' ')
        is_position = tokens.find_index('is')
        subject.parse_roman_number(tokens, is_position)
        expect(subject.dictionary.words).to be_empty
        expect(subject.dictionary).to have_exactly(0).words
      end
    end
  end

  describe '.parse_galaxy_number' do
    context 'Parse a valid Line' do
      subject { Parser.new }

      before do
        tokens = 'glob is I'.split(' ')
        is_position = tokens.find_index('is')
        subject.parse_roman_number(tokens, is_position)
      end
      it 'Returns a dictionary with new word' do
        tokens = 'glob glob Silver is 34 Credits'.split(' ')
        is_position = tokens.find_index('is')
        subject.parse_galaxy_number(tokens, is_position)
        expect(subject.dictionary.words).not_to be_empty
        expect(subject.dictionary.words).to include('Silver' => 17)
      end
    end

    context 'Parse a invalid Line' do
      subject { Parser.new }

      it 'Returns a empty dictionary' do
        tokens = 'asdsd asdasd is asdsd aasdsad'.split(' ')
        is_position = tokens.find_index('is')
        subject.parse_roman_number(tokens, is_position)
        expect(subject.dictionary.words).to be_empty
        expect(subject.dictionary).to have_exactly(0).words
      end
    end
  end
end
