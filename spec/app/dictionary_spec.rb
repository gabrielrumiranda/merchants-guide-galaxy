# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe Dictionary do
  let(:word_name) { 'Plac' }
  let(:word_value) { 52 }
  let(:dictionary) { described_class.new }

  describe '#add_word!' do
    subject(:add_word) { dictionary.add_word!(word_name, word_value) }

    context 'when dictionary is empty' do
      it 'add the new word' do
        expect(add_word).to eq(52)
      end
    end

    context 'when dictionary is not empty' do
      let(:word_name) { 'TumTum' }
      let(:word_value) { 30 }

      before do
        dictionary.words['Plac'] = 52
      end

      it 'add the new word' do
        expect(add_word).to eq(30)
      end

      it 'push the two words' do
        add_word
        expect(dictionary.words).to eq('Plac' => 52, 'TumTum' => 30)
      end
    end
  end
end
