# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe Parser do
  let(:tokens) { 'glob is I'.split(' ') }
  let(:tokens_is_position) { tokens.find_index('is') }
  let(:dictionary) { Dictionary.new }
  let(:parser) { described_class.new(dictionary: dictionary) }

  describe '#parse_roman_number!' do
    subject(:parse_roman_number) do
      parser.parse_roman_number!(tokens, tokens_is_position)
    end

    context 'when line is valid' do
      before do
        dictionary.words.clear
        parse_roman_number
      end

      it 'add new word in dictionary ' do
        expect(dictionary.words).to eq('glob' => 1)
      end
    end

    context 'when line is invalid' do
      let(:tokens) { 'asdsd asdasd is asdsd aasdsad'.split(' ') }

      before do
        parse_roman_number
      end

      it 'dictionary.word is empty' do
        expect(dictionary.words).to be_empty
      end
    end
  end

  describe '#parse_galaxy_number!' do
    subject(:parse_galaxy_number) do
      parser.parse_galaxy_number!(tokens, tokens_is_position)
    end

    context 'when line is valid' do
      let(:tokens) { 'glob glob Silver is 34 Credits'.split(' ') }

      before do
        dictionary.words['glob'] = 1
        parse_galaxy_number
      end

      it 'add the new word in dictionary ' do
        expect(dictionary.words).to eq('glob' => 1, 'Silver' => 17)
      end
    end

    context 'when line is invalid' do
      let(:tokens) { 'asdsd asdasd is asdsd aasdsad'.split(' ') }

      before do
        parse_galaxy_number
      end

      it 'dictionary is empty' do
        expect(dictionary.words).to be_empty
      end
    end
  end

  describe '#infer' do
    subject(:infer) { parser.infer(tokens, tokens_is_position) }

    context 'when line is valid' do
      let(:tokens) { 'how much is glob glob glob ?'.split(' ') }

      before do
        dictionary.words['glob'] = 1
      end

      it 'Returns the value inferred' do
        expect(infer).to eq(3)
      end
    end

    context 'when line is invalid' do
      let(:tokens) { 'glob glob glob ?'.split(' ') }

      before do
        dictionary.words['glob'] = 1
      end

      it 'Returns 0' do
        expect(infer).to eq(0)
      end
    end

    context 'when line have unknow numbers' do
      let(:tokens) { 'how much is glob glob glob ?'.split(' ') }

      it 'Returns 0' do
        expect(infer).to eq(0)
      end
    end
  end

  describe '#calculate_preliminar_number' do
    subject(:calculate_preliminar_number) do
      parser.calculate_preliminar_number(tokens)
    end

    context 'when tokens is empty' do
      let(:tokens) { [] }

      it 'Returns 0' do
        expect(calculate_preliminar_number).to eq(0)
      end
    end

    context 'when tokens is not empty' do
      let(:tokens) { %w[glob glob] }

      before do
        dictionary.words['glob'] = 1
      end

      it 'Returns the value of word' do
        expect(calculate_preliminar_number).to eq(2)
      end
    end
  end

  describe '#parse!' do
    subject(:parse) { parser.parse!(tokens) }

    context 'when the file_line is empty' do
      let(:tokens) { '' }

      it 'Returns error message' do
        expect(parse).to eq('I have no idea what you are talking about')
      end
    end

    context 'when the file_line is invalid' do
      let(:tokens) { 'asdasdsadas asdasd' }

      it 'Returns error message' do
        expect(parse).to eq('I have no idea what you are talking about')
      end
    end

    context 'when the file_line is a roman number defintion' do
      let(:tokens) { 'glob is I' }

      it 'Returns "-" ' do
        expect(parse).to eq('-')
      end

      it 'dictionary.word is equal inferred value ' do
        parse
        expect(dictionary.words).to eq('glob' => 1)
      end
    end

    context 'when the file_line is a galaxy number defintion' do
      context 'and have information to infer then' do
        let(:tokens) { 'glob glob Silver is 34 Credits' }

        before do
          dictionary.words['glob'] = 1
        end

        it 'Returns "-" ' do
          expect(parse).to eq('-')
        end

        it 'dictionary.word is equal inferred values' do
          parse
          expect(dictionary.words).to eq('Silver' => 17.0, 'glob' => 1)
        end
      end

      context 'and not have information to infer then' do
        let(:tokens) { 'glob glob Silver is 34 Credits' }

        it 'Returns "-" ' do
          expect(parse).to eq('-')
        end

        it 'dictionary.word is empty' do
          expect(dictionary.words).to be_empty
        end
      end
    end

    context 'when the file_line is a question' do
      context 'and have information to infer then' do
        let(:tokens) { 'how much is glob glob glob ?' }

        before do
          dictionary.words['glob'] = 1
        end

        it 'Returns the awnser of line ' do
          expect(parse).to eq(3)
        end
      end

      context 'and not have information to infer then' do
        let(:tokens) { 'how much is glob glob glob ?' }

        it 'Returns 0 ' do
          expect(parse).to eq(0)
        end
      end
    end
  end
end
