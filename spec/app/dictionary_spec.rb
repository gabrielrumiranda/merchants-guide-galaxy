# frozen_string_literal: true
require_relative '../spec_helper'

RSpec.describe 'Dictionary' do
  let(:word_name) { 'Plac' }
  let(:word_value) { 52 }
  let(:dictionary) { Dictionary.new }

  describe '.add_word' do
    subject(:add_word) { dictionary.add_word(word_name, word_value) }

    context 'when words is empty' do
      it 'Dictionary.words is equal 52}' do
        expect(add_word).to eq(52)
      end
    end

    context 'when words is not empty' do
      let(:word_name) { 'TumTum' }
      let(:word_value) { 30 }

      before do
        dictionary.words['Plac'] = 52
        subject
      end

      it 'adds the new word to dictionary' do
        expect(add_word).to eq(30)
      end

      it 'dictionary.words have 2 words' do
        expect(dictionary.words).to eq('Plac' => 52, 'TumTum' => 30)
      end
    end
  end
end
