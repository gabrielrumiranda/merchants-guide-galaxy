# frozen_string_literal: true

require_relative '../spec_helper'
RSpec.describe 'Dictionary' do
  describe '.add_word' do
    context 'when words is empty' do
      subject(:dictionary) { Dictionary.new.add_word('Plact', 52) }

      it 'Dictionary.words is equal 52}' do
        expect(dictionary).to eq(52)
      end
    end

    context 'when words is not empty' do
      subject(:dictionary) { Dictionary.new }

      before do
        dictionary.add_word('Plact', 52)
        dictionary.add_word('Zum', 30)
      end

      it 'adds the new word to dictionary' do
        expect(dictionary.words).to eq('Plact' => 52, 'Zum' => 30)
      end
    end
  end
end
