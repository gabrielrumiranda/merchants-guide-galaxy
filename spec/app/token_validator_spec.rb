# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'TokenValidator' do
  let(:roman_i) { Token.new('I', 1) }
  let(:roman_v) { Token.new('V', 5) }
  let(:roman_x) { Token.new('X', 10) }
  let(:galaxy_number) { Token.new('glub', 4) }

  describe '#roman?' do
    subject(:roman) { TokenValidator.roman?(value) }

    context 'when number is roman' do
      let(:value) { 10 }

      it 'Returns true' do
        expect(roman).to eq(true)
      end
    end

    context 'when number is not roman' do
      let(:value) { 3 }

      it 'Returns true' do
        expect(roman).to eq(false)
      end
    end
  end

  describe '#valid_roman_precedence?' do
    subject(:valid) { TokenValidator.valid_roman_precedence?(value, buffer) }

    context 'when the buffer is empty' do
      let(:value) { 1 }
      let(:buffer) { [] }

      it 'Returns true' do
        expect(valid).to eq(true)
      end
    end

    context 'when there is a roman number in the buffer' do
      let(:value) { 5 }
      let(:buffer) { [roman_i] }

      it 'Returns true' do
        expect(valid).to eq(true)
      end
    end

    context 'when have a roman number in buffer and you want add a lesser number' do
      let(:value) { 1 }
      let(:buffer) { [roman_v] }

      it 'Returns true' do
        expect(valid).to eq(true)
      end
    end

    context 'when have a roman number in buffer and you want add a bigger valid number' do
      let(:value) { 5 }
      let(:buffer) { [roman_i] }

      it 'Returns true' do
        expect(valid).to eq(true)
      end
    end

    context 'when have a roman number in buffer and you want add a bigger invalid number' do
      let(:value) { 10 }
      let(:buffer) { [roman_i] }

      it 'Returns false' do
        expect(valid).to eq(false)
      end
    end

    context 'when have the same roman number 3 times in buffer and you want add other time' do
      let(:value) { 1 }
      let(:buffer) { [roman_i, roman_i, roman_i] }

      it 'Returns false' do
        expect(valid).to eq(false)
      end
    end
  end

  describe '#valid_token_push?' do
    subject(:valid) { TokenValidator.valid_token_push?(value, buffer) }

    context 'when number what do you want push is not roman' do
      let(:value) { galaxy_number }
      let(:buffer) { [roman_i] }

      it 'Returns true' do
        expect(valid).to eq(true)
      end
    end

    context 'when the buffer is empty' do
      let(:value) { roman_v }
      let(:buffer) { [] }

      it 'Returns true' do
        expect(valid).to eq(true)
      end
    end

    context 'when number what do you want push is roman and not invalidate the precedence' do
      let(:value) { roman_v }
      let(:buffer) { [roman_i] }

      it 'Returns true' do
        expect(valid).to eq(true)
      end
    end

    context 'when number what do you want push is roman and invalidate the precedence' do
      let(:value) { roman_x }
      let(:buffer) { [roman_i] }

      it 'Returns false' do
        expect(valid).to eq(false)
      end
    end
  end
end
