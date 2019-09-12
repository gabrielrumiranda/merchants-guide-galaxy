require_relative '../spec_helper'

RSpec.describe 'Parser' do
  subject do
    Parser.new(dictionary: dictionary)
  end
  describe '.parse_roman_number' do

    context 'Parse a valid Line' do

      let(:dictionary) { Dictionary.new }

      before do
        tokens = 'glob is I'.split(' ')
        is_position = tokens.find_index('is')
        subject.parse_roman_number(tokens, is_position)
      end

      it 'dictionary.word is not empty' do
        expect(dictionary.words).not_to be_empty
      end

      it 'dictionary have exaclty 1 word' do
        expect(dictionary).to have_exactly(1).words
      end

      it 'dictionary.words include (glob => 1) ' do
        expect(dictionary.words).to include('glob' => 1)
      end
    end

    context 'Parse a invalid Line' do

      let(:dictionary) { Dictionary.new }

      before do
        tokens = 'asdsd asdasd is asdsd aasdsad'.split(' ')
        is_position = tokens.find_index('is')
        subject.parse_roman_number(tokens, is_position)
      end

      it 'dictionary.word is empty' do
        expect(dictionary.words).to be_empty
      end

      it 'dictionary have exaclty 0 word' do
        expect(dictionary).to have_exactly(0).words
      end
    end
  end

  describe '.parse_galaxy_number' do
    context 'Parse a valid Line' do
      let(:dictionary) { Dictionary.new }

      before do
        roman_tokens = 'glob is I'.split(' ')
        roman_is_position = roman_tokens.find_index('is')
        subject.parse_roman_number(roman_tokens, roman_is_position)
        galaxy_tokens = 'glob glob Silver is 34 Credits'.split(' ')
        galaxy_is_position = galaxy_tokens.find_index('is')
        subject.parse_galaxy_number(galaxy_tokens, galaxy_is_position)
      end

      it 'dictionary.word is not empty' do
        expect(dictionary.words).not_to be_empty
      end

      it 'dictionary.word include (Silver => 17) ' do
        expect(dictionary.words).to include('Silver' => 17)
      end
    end

    context 'Parse a invalid Line' do
      let(:dictionary) { Dictionary.new }

      before do
        tokens = 'asdsd asdasd is asdsd aasdsad'.split(' ')
        is_position = tokens.find_index('is')
        subject.parse_roman_number(tokens, is_position)
      end

      it 'Dictionary is empty' do
        expect(dictionary.words).to be_empty
      end

      it 'Dictionary have 0 words' do
        expect(dictionary).to have_exactly(0).words
      end
    end
  end

  describe '.infer' do
    context 'Infer a valid Line' do
      let(:dictionary) { Dictionary.new }

      before do
        roman_tokens = 'glob is I'.split(' ')
        roman_is_position = roman_tokens.find_index('is')
        subject.parse_roman_number(roman_tokens, roman_is_position)
      end

      it 'Returns 3' do
        infer_tokens = 'how much is glob glob glob ?'.split(' ')
        infer_is_position = infer_tokens.find_index('is')
        expect(subject.infer(infer_tokens, infer_is_position)).to eq(3)
      end
    end

    context 'Infer a invalid Line' do
      let(:dictionary) { Dictionary.new }

      before do
        roman_tokens = 'glob is I'.split(' ')
        roman_is_position = roman_tokens.find_index('is')
        subject.parse_roman_number(roman_tokens, roman_is_position)
      end

      it 'Returns 0' do
        infer_tokens = 'glob glob glob'.split(' ')
        infer_is_position = infer_tokens.find_index('is')
        expect(subject.infer(infer_tokens, infer_is_position)).to eq(0)
      end
    end

    context 'Infer a valid Line with unknow numbers' do
      let(:dictionary) { Dictionary.new }

      it 'Returns nil' do
        infer_tokens = 'how much is glob glob glob ?'.split(' ')
        infer_is_position = infer_tokens.find_index('is')
        expect(subject.infer(infer_tokens, infer_is_position)).to eq(nil)
      end
    end
  end
end