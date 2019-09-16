# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'Line' do
  let(:roman_i) { Token.new('I', 1) }
  let(:roman_v) { Token.new('V', 5) }
  let(:roman_x) { Token.new('X', 10) }
  let(:galaxy_number) { Token.new('glub', 2) }

  describe '.push' do
    context 'Tokens is empty and push some token' do
      subject(:line) { Line.new }

      before do
        line.push(roman_x)
      end

      it 'Line.tokens is equal a array with the pushed tokens' do
        expect(subject.tokens).to eq([roman_x])
      end
    end

    context 'Tokens is not empty and push some token' do
      subject(:line) { Line.new }

      before do
        line.push(roman_i)
        line.push(roman_x)
      end

      it 'Line.tokens is equal a array with the two pushed tokens' do
        expect(line.tokens).to eq([roman_i, roman_x])
      end
    end
  end

  describe '.add_buffer' do
    context 'Tokens is empty and push some token to buffer' do
      subject(:line) { Line.new }

      before do
        line.add_buffer(roman_x)
      end

      it 'Line.tokens is equal the added token' do
        expect(line.tokens).to eql([roman_x])
      end

      it 'Line.accumulate is equal 10' do
        expect(line.accumulate).to eq(10)
      end
    end

    context 'Have a Roman number in buffer and push a bigger roman number' do
      subject(:line) { Line.new }

      before do
        line.add_buffer(roman_i)
        line.add_buffer(roman_v)
      end

      it 'Line.tokens is equal the added tokens' do
        expect(subject.tokens).to eq([roman_i, roman_v])
      end

      it 'Line.accumulate is equal 4' do
        expect(subject.accumulate).to eq(4)
      end
    end

    context 'Have a Roman number in buffer and push a smaller roman number' do
      subject(:line) { Line.new }

      before do
        line.add_buffer(roman_x)
        line.add_buffer(roman_v)
      end

      it 'Line.tokens is equal the added tokens' do
        expect(subject.tokens).to eq([roman_x, roman_v])
      end

      it 'Line.accumulate is equal 15' do
        expect(subject.accumulate).to eq(15)
      end
    end

    context 'Have a Roman number in buffer and push a galaxy number' do
      subject(:line) { Line.new }

      before do
        line.add_buffer(roman_x)
        line.add_buffer(galaxy_number)
      end

      it 'Line.tokens is equal the added tokens' do
        expect(subject.tokens).to eq([roman_x, galaxy_number])
      end

      it 'Line.accumulate is equal 20' do
        expect(subject.accumulate).to eq(20)
      end
    end

    context 'Have three equal Roman number in buffer and push a the same number' do
      subject(:line) { Line.new }

      before do
        line.add_buffer(roman_x)
        line.add_buffer(roman_x)
        line.add_buffer(roman_x)
      end

      it 'Line.tokens is equal the added tokens' do
        expect(line.tokens).to eq([roman_x, roman_x, roman_x])
      end

      it 'Line.accumulate is equal 30' do
        expect(subject.accumulate).to eq(30)
      end
    end

    context 'Have a Roman number in buffer and push an invalid roman number' do
      subject(:line) { Line.new }

      before do
        line.add_buffer(roman_i)
        line.add_buffer(roman_x)
      end

      it 'Line.tokens is equal the first token pushed' do
        expect(line.tokens).to eq([roman_i])
      end

      it 'Line.accumulate is equal 1' do
        expect(line.accumulate).to eq(1)
      end
    end
  end
end
