# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'Parser' do
  subject(:parser) { Parser.new(dictionary: dictionary) }
  let(:glob) { 'glob is I'.split(' ') }

  describe '.parse_roman_number' do
    context 'Parse a valid Line' do
      let(:dictionary) { Dictionary.new }

      before do
        is_position = glob.find_index('is')
        parser.parse_roman_number(glob, is_position)
      end

      it 'dictionary.words is equal (glob => 1) ' do
        expect(dictionary.words).to eq('glob' => 1)
      end
    end

    context 'Parse a invalid Line' do
      let(:dictionary) { Dictionary.new }

      before do
        tokens = 'asdsd asdasd is asdsd aasdsad'.split(' ')
        is_position = tokens.find_index('is')
        parser.parse_roman_number(tokens, is_position)
      end

      it 'dictionary.word is empty' do
        expect(dictionary.words).to be_empty
      end
    end
  end

  describe '.parse_galaxy_number' do
    context 'Parse a valid Line' do
      let(:dictionary) { Dictionary.new }

      before do
        roman_is_position = glob.find_index('is')
        parser.parse_roman_number(glob, roman_is_position)
        galaxy_tokens = 'glob glob Silver is 34 Credits'.split(' ')
        galaxy_is_position = galaxy_tokens.find_index('is')
        parser.parse_galaxy_number(galaxy_tokens, galaxy_is_position)
      end

      it 'dictionary.word is equal (glob => 1, Silver => 17) ' do
        expect(dictionary.words).to eq('glob' => 1, 'Silver' => 17)
      end
    end

    context 'Parse a invalid Line' do
      let(:dictionary) { Dictionary.new }

      before do
        tokens = 'asdsd asdasd is asdsd aasdsad'.split(' ')
        is_position = tokens.find_index('is')
        parser.parse_roman_number(tokens, is_position)
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
        roman_is_position = glob.find_index('is')
        parser.parse_roman_number(glob, roman_is_position)
      end

      it 'Returns 3' do
        infer_tokens = 'how much is glob glob glob ?'.split(' ')
        infer_is_position = infer_tokens.find_index('is')
        expect(parser.infer(infer_tokens, infer_is_position)).to eq(3)
      end
    end

    context 'Infer a invalid Line' do
      let(:dictionary) { Dictionary.new }

      before do
        roman_is_position = glob.find_index('is')
        parser.parse_roman_number(glob, roman_is_position)
      end

      it 'Returns 0' do
        infer_tokens = 'glob glob glob'.split(' ')
        infer_is_position = infer_tokens.find_index('is')
        expect(parser.infer(infer_tokens, infer_is_position)).to eq(0)
      end
    end

    context 'Infer a valid Line with unknow numbers' do
      let(:dictionary) { Dictionary.new }

      it 'Returns nil' do
        infer_tokens = 'how much is glob glob glob ?'.split(' ')
        infer_is_position = infer_tokens.find_index('is')
        expect(parser.infer(infer_tokens, infer_is_position)).to eq(nil)
      end
    end
  end

  describe '.calculate_preliminar_number' do
    context 'when the tokens is empty' do
      let(:dictionary) { Dictionary.new }

      it 'Returns 0' do
        expect(parser.calculate_preliminar_number([])).to eq(0)
      end
    end

    context 'when the tokens is not empty' do
      let(:dictionary) { Dictionary.new }

      before do
        roman_is_position = glob.find_index('is')
        parser.parse_roman_number(glob, roman_is_position)
      end

      it 'Returns 2' do
        expect(parser.calculate_preliminar_number(%w[glob glob])).to eq(2)
      end
    end
  end

  describe '.parser' do
    context 'when the file_line is empty' do
      let(:dictionary) { Dictionary.new }

      it 'Returns "I have no idea what you are talking about"' do
        expect(parser.parse('')).to eq('I have no idea what you are talking about')
      end
    end

    context 'when the file_line is invalid' do
      let(:dictionary) { Dictionary.new }

      it 'Returns "I have no idea what you are talking about"' do
        expect(parser.parse('asdasdsadas asdasd')).to eq('I have no idea what you are talking about')
      end
    end

    context 'when the file_line is a roman number defintion' do
      let(:dictionary) { Dictionary.new }

      it 'Returns "-" ' do
        expect(parser.parse('glob is I')).to eq('-')
      end

      it 'dictionary.word is equal (glob => 1) ' do
        parser.parse('glob is I')
        expect(dictionary.words).to eq('glob' => 1)
      end
    end

    context 'when the file_line is a galaxy number defintion and have information to infer then' do
      let(:dictionary) { Dictionary.new }

      before do
        roman_tokens = 'glob is I'.split(' ')
        roman_is_position = roman_tokens.find_index('is')
        parser.parse_roman_number(roman_tokens, roman_is_position)
      end

      it 'Returns "-" ' do
        expect(parser.parse('glob glob Silver is 34 Credits')).to eq('-')
      end

      it 'dictionary.word is equal (Silver => 17.0, glob => 1) ' do
        parser.parse('glob glob Silver is 34 Credits')
        expect(dictionary.words).to eq('Silver' => 17.0, 'glob' => 1)
      end
    end

    context 'when the file_line is a galaxy number defintion and not have information to infer then' do
      let(:dictionary) { Dictionary.new }

      it 'Returns "-" ' do
        expect(parser.parse('glob glob Silver is 34 Credits')).to eq('-')
      end

      it 'dictionary.word is empty' do
        parser.parse('glob glob Silver is 34 Credits')
        expect(dictionary.words).to be_empty
      end
    end

    context 'when the file_line is a question and have information to infer then' do
      let(:dictionary) { Dictionary.new }

      before do
        roman_tokens = 'glob is I'.split(' ')
        roman_is_position = roman_tokens.find_index('is')
        parser.parse_roman_number(roman_tokens, roman_is_position)
      end

      it 'Returns 3 ' do
        expect(parser.parse('how much is glob glob glob ?')).to eq(3)
      end
    end

    context 'when the file_line is a question and not have information to infer then' do
      let(:dictionary) { Dictionary.new }

      it 'Returns nil ' do
        expect(parser.parse('how much is glob glob glob ?')).to eq(nil)
      end
    end
  end
end
