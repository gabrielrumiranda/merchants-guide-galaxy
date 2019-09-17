# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'Parser' do
  let(:tokens) { 'glob is I'.split(' ') }
  let(:tokens_is_position) { tokens.find_index('is') }
  let(:dictionary) { Dictionary.new }
  describe '#parse_roman_number!' do
    subject(:parser) do
      Parser.new(dictionary: dictionary)
            .parse_roman_number!(tokens, tokens_is_position)
    end

    context 'when line is valid' do
      before do
        dictionary.words.clear
        subject
      end

      it 'add new word in dictionary ' do
        expect(dictionary.words).to eq('glob' => 1)
      end
    end

    context 'when line  is invalid' do
      let(:tokens) { 'asdsd asdasd is asdsd aasdsad'.split(' ') }

      before do
        subject
      end

      it 'dictionary.word is empty' do
        expect(dictionary.words).to be_empty
      end
    end
  end

  describe '#parse_galaxy_number!' do
    subject(:parser) do
      Parser.new(dictionary: dictionary)
            .parse_galaxy_number!(tokens, tokens_is_position)
    end
    context 'when line is valid' do
      let(:tokens) { 'glob glob Silver is 34 Credits'.split(' ') }

      before do
        dictionary.words['glob'] = 1
        subject
      end

      it 'add the new word in dictionary ' do
        expect(dictionary.words).to eq('glob' => 1, 'Silver' => 17)
      end
    end

    context 'when line is invalid' do
      let(:tokens) { 'asdsd asdasd is asdsd aasdsad'.split(' ') }

      before do
        subject
      end

      it 'dictionary is empty' do
        expect(dictionary.words).to be_empty
      end
    end
  end

  describe '#infer' do
    subject(:parser) do
      Parser.new(dictionary: dictionary)
            .infer(tokens, tokens_is_position)
    end

    context 'when line is valid' do
      let(:tokens) { 'how much is glob glob glob ?'.split(' ') }

      before do
        dictionary.words['glob'] = 1
      end

      it 'Returns the value inferred' do
        expect(parser).to eq(3)
      end
    end

    context 'when line is invalid' do
      let(:tokens) { 'glob glob glob ?'.split(' ') }

      before do
        dictionary.words['glob'] = 1
      end

      it 'Returns 0' do
        expect(parser).to eq(0)
      end
    end

    context 'when line have unknow numbers' do
      let(:tokens) { 'how much is glob glob glob ?'.split(' ') }

      it 'Returns 0' do
        expect(parser).to eq(0)
      end
    end
  end

  describe '#calculate_preliminar_number' do
    subject(:parser) do
      Parser.new(dictionary: dictionary)
            .calculate_preliminar_number(tokens)
    end

    context 'when tokens is empty' do
      let(:tokens) { [] }

      it 'Returns 0' do
        expect(parser).to eq(0)
      end
    end

    context 'when tokens is not empty' do
      let(:tokens) { %w[glob glob] }

      before do
        dictionary.words['glob'] = 1
      end

      it 'Returns the value of word' do
        expect(parser).to eq(2)
      end
    end
  end

  describe '#parse!' do
    subject(:parser) { Parser.new(dictionary: dictionary).parse!(tokens) }

    context 'when the file_line is empty' do
      let(:tokens) { '' }

      it 'Returns "I have no idea what you are talking about"' do
        expect(parser).to eq('I have no idea what you are talking about')
      end
    end

    context 'when the file_line is invalid' do
      let(:tokens) { 'asdasdsadas asdasd' }

      it 'Returns "I have no idea what you are talking about"' do
        expect(parser).to eq('I have no idea what you are talking about')
      end
    end

    context 'when the file_line is a roman number defintion' do
      let(:tokens) { 'glob is I' }

      before do
        parser
      end

      it 'Returns "-" ' do
        expect(parser).to eq('-')
      end

      it 'dictionary.word is equal inferred value ' do
        expect(dictionary.words).to eq('glob' => 1)
      end
    end

    context 'when the file_line is a galaxy number defintion' do
      context 'and have information to infer then' do
        let(:tokens) { 'glob glob Silver is 34 Credits' }

        before do
          dictionary.words['glob'] = 1
          parser
        end

        it 'Returns "-" ' do
          expect(parser).to eq('-')
        end

        it 'dictionary.word is equal inferred values' do
          expect(dictionary.words).to eq('Silver' => 17.0, 'glob' => 1)
        end
      end

      context 'and not have information to infer then' do
        let(:tokens) { 'glob glob Silver is 34 Credits' }

        it 'Returns "-" ' do
          expect(parser).to eq('-')
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
          expect(parser).to eq(3)
        end
      end

      context 'and not have information to infer then' do
        let(:tokens) { 'how much is glob glob glob ?' }

        before do
          subject
        end

        it 'Returns 0 ' do
          expect(parser).to eq(0)
        end
      end
    end
  end
end
