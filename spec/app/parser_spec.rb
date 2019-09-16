# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'Parser' do
  
  let(:tokens) { 'glob is I'.split(' ') }
  let(:tokens_is_position) { tokens.find_index('is') }
  let!(:dictionary) { Dictionary.new }
  describe '.parse_roman_number' do
    subject(:parser) { Parser.new(dictionary: dictionary).parse_roman_number(tokens, tokens_is_position) }

    context 'Parse a invalid Line' do

      before do
        dictionary.words.clear
        subject
      end

      it 'dictionary.words is equal (glob => 1) ' do
        expect(dictionary.words).to eq('glob' => 1)
      end
    end

    context 'Parse a invalid Line' do
      let(:tokens) { 'asdsd asdasd is asdsd aasdsad'.split(' ') }
      let(:tokens_is_position) { tokens.find_index('is') }

      before do
        subject
      end

      it 'dictionary.word is empty' do
        expect(dictionary.words).to be_empty
      end
    end
  end

  describe '.parse_galaxy_number' do
    subject(:parser) { Parser.new(dictionary: dictionary).parse_galaxy_number(tokens, tokens_is_position) }
    context 'Parse a valid Line' do
      let(:tokens) { 'glob glob Silver is 34 Credits'.split(' ') }
      let(:tokens_is_position) { tokens.find_index('is') }

      before do
        dictionary.words['glob'] = 1
        subject
      end

      it 'dictionary.word is equal (glob => 1, Silver => 17) ' do
        expect(dictionary.words).to eq('glob' => 1, 'Silver' => 17)
      end
    end

    context 'Parse a invalid Line' do
      let(:tokens) { 'asdsd asdasd is asdsd aasdsad'.split(' ') }
      let(:tokens_is_position) { tokens.find_index('is') }

      before do
        subject
      end

      it 'Dictionary is empty' do
        expect(dictionary.words).to be_empty
      end
    end
  end

  describe '.infer' do
    subject(:parser) { Parser.new(dictionary: dictionary).infer(tokens, tokens_is_position) }

    context 'Infer a valid Line' do
      let(:tokens) { 'how much is glob glob glob ?'.split(' ') }
      let(:tokens_is_position) { tokens.find_index('is') }

      before do
        dictionary.words['glob'] = 1
        subject
      end

      it 'Returns 3' do
        expect(parser).to eq(3)
      end
    end

    context 'Infer a invalid Line' do
      let(:tokens) { 'glob glob glob ?'.split(' ') }
      let(:tokens_is_position) { tokens.find_index('is') }

      before do
        dictionary.words['glob'] = 1
        subject
      end

      it 'Returns 0' do
        expect(parser).to eq(0)
      end
    end

    context 'Infer a valid Line with unknow numbers' do
      let(:tokens) { 'how much is glob glob glob ?'.split(' ') }
      let(:tokens_is_position) { tokens.find_index('is') }

      before do
        subject
      end

      it 'Returns nil' do
        expect(parser).to eq(nil)
      end
    end
  end

  describe '.calculate_preliminar_number' do
    subject(:parser) { Parser.new(dictionary: dictionary).calculate_preliminar_number(tokens) }

    context 'when the tokens is empty' do
      let(:tokens) { [] }

      before do
        subject
      end

      it 'Returns 0' do
        expect(parser).to eq(0)
      end
    end

    context 'when the tokens is not empty' do
      let(:tokens) { %w[glob glob] }

      before do
        dictionary.words['glob'] = 1
        subject
      end


      it 'Returns 2' do
        expect(parser).to eq(2)
      end
    end
  end

  describe '.parser' do
    subject(:parser) { Parser.new(dictionary: dictionary).parse(tokens) }

    context 'when the file_line is empty' do
      let(:tokens) { '' }

      before do
        subject
      end

      it 'Returns "I have no idea what you are talking about"' do
        expect(parser).to eq('I have no idea what you are talking about')
      end
    end

    context 'when the file_line is invalid' do
      let(:tokens) { 'asdasdsadas asdasd' }

      before do
        subject
      end


      it 'Returns "I have no idea what you are talking about"' do
        expect(parser).to eq('I have no idea what you are talking about')
      end
    end

    context 'when the file_line is a roman number defintion' do
      let(:tokens) { 'glob is I' }

      before do
        subject
      end

      it 'Returns "-" ' do
        expect(parser).to eq('-')
      end

      it 'dictionary.word is equal (glob => 1) ' do
        expect(dictionary.words).to eq('glob' => 1)
      end
    end

    context 'when the file_line is a galaxy number defintion and have information to infer then' do
      let(:tokens) { 'glob glob Silver is 34 Credits' }

      before do
        dictionary.words['glob'] = 1
        subject
      end

      it 'Returns "-" ' do
        expect(parser).to eq('-')
      end

      it 'dictionary.word is equal (Silver => 17.0, glob => 1) ' do
        expect(dictionary.words).to eq('Silver' => 17.0, 'glob' => 1)
      end
    end

    context 'when the file_line is a galaxy number defintion and not have information to infer then' do
      let(:tokens) { 'glob glob Silver is 34 Credits' }

      before do
        subject
      end

      it 'Returns "-" ' do
        expect(parser).to eq('-')
      end

      it 'dictionary.word is empty' do
        expect(dictionary.words).to be_empty
      end
    end

    context 'when the file_line is a question and have information to infer then' do
      let(:tokens) { 'how much is glob glob glob ?' }

      before do
        dictionary.words['glob'] = 1
        subject
      end

      it 'Returns 3 ' do
        expect(parser).to eq(3)
      end
    end

    context 'when the file_line is a question and not have information to infer then' do
      let(:tokens) { 'how much is glob glob glob ?' }

      before do
        subject
      end

      it 'Returns nil ' do
        expect(parser).to eq(nil)
      end
    end
  end
end
