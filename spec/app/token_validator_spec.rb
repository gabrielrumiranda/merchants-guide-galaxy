# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'TokenValidator' do
  let(:roman_i) { Token.new('I', 1) }
  let(:roman_v) { Token.new('V', 5) }
  let(:roman_x) { Token.new('X', 10) }
  let(:galaxy_number) { Token.new('glub', 4) }

  describe '#roman?' do
    context 'when number is roman' do
      subject(:roman) { TokenValidator.roman?(10) }

      it 'Returns true' do
        expect(roman).to eq(true)
      end
    end

    context 'when number is not roman' do
      subject(:roman) { TokenValidator.roman?(3) }

      it 'Returns true' do
        expect(roman).to eq(false)
      end
    end
  end

  describe '#valid_roman_precedence?' do
    context 'when the buffer is empty' do
      subject(:valid) { TokenValidator.valid_roman_precedence?(10, []) }

      it 'Returns true' do
        expect(valid).to eq(true)
      end
    end

    context 'when the have a roman number in buffer and you want add same number' do
      subject(:valid) { TokenValidator.valid_roman_precedence?(1, [roman_i]) }

      it 'Returns true' do
        expect(valid).to eq(true)
      end
    end

    context 'when the have a roman number in buffer and you want add a lesser number' do
      subject(:valid) { TokenValidator.valid_roman_precedence?(1, [roman_v]) }

      it 'Returns true' do
        expect(valid).to eq(true)
      end
    end

    context 'when the have a roman number in buffer and you want add a bigger valid number' do
      subject(:valid) { TokenValidator.valid_roman_precedence?(5, [roman_i]) }

      it 'Returns true' do
        expect(valid).to eq(true)
      end
    end

    context 'when the have a roman number in buffer and you want add a bigger invalid number' do
      subject(:valid) { TokenValidator.valid_roman_precedence?(10, [roman_i]) }

      it 'Returns false' do
        expect(valid).to eq(false)
      end
    end

    context 'when the have the same roman number 3 times in buffer and you want add other time' do
      subject(:valid) { TokenValidator.valid_roman_precedence?(1, [roman_i, roman_i, roman_i]) }

      it 'Returns false' do
        expect(valid).to eq(false)
      end
    end
  end

  describe '#valid_token_push?' do
    context 'when number what do you want push is not roman' do
      subject(:valid) { TokenValidator.valid_token_push?(galaxy_number, [roman_i]) }

      it 'Returns true' do
        expect(valid).to eq(true)
      end
    end

    context 'when the buffer is empty' do
      subject(:valid) { TokenValidator.valid_token_push?(roman_v, []) }

      it 'Returns true' do
        expect(valid).to eq(true)
      end
    end

    context 'when number what do you want push is roman and not invalidate the precedence' do
      subject(:valid) { TokenValidator.valid_token_push?(roman_v, [roman_i]) }

      it 'Returns true' do
        expect(valid).to eq(true)
      end
    end

    context 'when number what do you want push is roman and invalidate the precedence' do
      subject(:valid) { TokenValidator.valid_token_push?(roman_x, [roman_i]) }

      it 'Returns false' do
        expect(valid).to eq(false)
      end
    end
  end
end
