# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe TokenValidator do
  let(:roman_i) { Token.new('I', 1) }
  let(:roman_v) { Token.new('V', 5) }
  let(:roman_x) { Token.new('X', 10) }
  let(:galaxy_number) { Token.new('glub', 4) }

  describe '.roman?' do
    subject(:roman) { described_class.roman?(value) }

    context 'when number is roman' do
      let(:value) { 10 }

      it 'returns true' do
        expect(roman).to eq(true)
      end
    end

    context 'when number is not roman' do
      let(:value) { 3 }

      it 'returns true' do
        expect(roman).to eq(false)
      end
    end
  end

  describe '.valid_roman_precedence?' do
    subject(:valid) { described_class.valid_roman_precedence?(value, buffer) }

    context 'when the buffer is empty' do
      let(:value) { 1 }
      let(:buffer) { [] }

      it 'returns true' do
        expect(valid).to eq(true)
      end
    end

    context 'when there is a roman number in the buffer' do
      let(:value) { 5 }
      let(:buffer) { [roman_i] }

      it 'returns true' do
        expect(valid).to eq(true)
      end

      context 'and you want add a lesser number' do
        let(:value) { 1 }
        let(:buffer) { [roman_v] }

        it 'returns true' do
          expect(valid).to eq(true)
        end
      end

      context 'and you want add a bigger valid number' do
        let(:value) { 5 }
        let(:buffer) { [roman_i] }

        it 'returns true' do
          expect(valid).to eq(true)
        end
      end

      context 'and you want add a bigger invalid number' do
        let(:value) { 10 }
        let(:buffer) { [roman_i] }

        it 'returns false' do
          expect(valid).to eq(false)
        end
      end
    end

    context 'when have the same roman number 3 times in buffer' do
      context 'and you want add other time' do
        let(:value) { 1 }
        let(:buffer) { [roman_i, roman_i, roman_i] }

        it 'returns false' do
          expect(valid).to eq(false)
        end
      end
    end
  end

  describe '.valid_token_push?' do
    subject(:valid) { described_class.valid_token_push?(value, buffer) }

    context 'when number what do you want push is not roman' do
      let(:value) { galaxy_number }
      let(:buffer) { [roman_i] }

      it 'returns true' do
        expect(valid).to eq(true)
      end
    end

    context 'when the buffer is empty' do
      let(:value) { roman_v }
      let(:buffer) { [] }

      it 'returns true' do
        expect(valid).to eq(true)
      end
    end

    context 'when number what do you want push is roman' do
      context 'and not invalidate the precedence' do
        let(:value) { roman_v }
        let(:buffer) { [roman_i] }

        it 'returns true' do
          expect(valid).to eq(true)
        end
      end

      context 'and invalidate the precedence' do
        let(:value) { roman_x }
        let(:buffer) { [roman_i] }

        it 'returns false' do
          expect(valid).to eq(false)
        end
      end
    end
  end

  describe '.valid_three_number_rule?' do
    subject(:valid) { described_class.valid_three_number_rule?(value, buffer) }

    context 'when buffer size is less than 3' do
      let(:value) { 10 }
      let(:buffer) { [] }

      it 'returns true' do
        expect(valid).to eq(true)
      end
    end

    context 'when the same value occurs more than 3 times in buffer' do
      context 'and the value you try add is the same number' do
        let(:value) { 5 }
        let(:buffer) { [roman_x, roman_v, roman_v, roman_v] }

        it 'returns false' do
          expect(valid).to eq(false)
        end
      end

      context 'and the value you try add other number' do
        let(:value) { 1 }
        let(:buffer) { [roman_x, roman_v, roman_v, roman_v] }

        it 'returns true' do
          expect(valid).to eq(true)
        end
      end
    end
  end
end
