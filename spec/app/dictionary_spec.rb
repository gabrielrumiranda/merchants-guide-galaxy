# frozen_string_literal: true

require_relative '../spec_helper'
RSpec.describe 'Dictionary' do
  describe '.add_word' do

    context 'Words is empty and add some word' do
      subject(:dictionary) { Dictionary.new }

      before { dictionary.add_word('Plact', 52) }

      it 'Dictionary.words is equal {Plact => 52}' do
        puts dictionary.words
        expect(dictionary.words).to eq('Plact' => 52)
      end
    end

    context 'Words is not empty and add some word' do
      subject(:dictionary) { Dictionary.new }

      before do
        dictionary.add_word('Plact', 52)
        dictionary.add_word('Zum', 30)
      end

      it 'Dictionary.words is queal {Plact => 52 , Zum => 30}' do
        expect(dictionary.words).to eq('Plact' => 52, 'Zum' => 30)
      end
    end
  end
end
