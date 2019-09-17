# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'Line' do
  let(:roman_i) { Token.new('I', 1) }
  let(:roman_v) { Token.new('V', 5) }
  let(:roman_x) { Token.new('X', 10) }
  let(:galaxy_number) { Token.new('glub', 2) }
  let(:line) { Line.new }

  describe '#push!' do
    subject(:push) { line.push!(token) }

    context 'when tokens is empty' do
      let(:token) { roman_x }

      it 'returns the pushed token' do
        expect(push).to eq([roman_x])
      end
    end

    context 'when tokens is not empty' do
      let(:token) { roman_x }

      before do
        line.push!(roman_i)
        push
      end

      it 'returns the pushed tokens' do
        expect(push).to eq([roman_i, roman_x])
      end
    end
  end

  describe '#add_buffer!' do
    subject(:add_buffer) { line.add_buffer!(token) }

    context 'when tokens is empty' do
      let(:token) { roman_x }

      it 'returns the added token' do
        expect(add_buffer).to eql([roman_x])
      end

      before do
        add_buffer
      end

      it 'Line.accumulate is equal 10' do
        expect(line.accumulate).to eq(10)
      end
    end

    context 'when have a roman number in buffer' do
      context 'and push a bigger roman number' do
        let(:token) { roman_v }

        before do
          line.add_buffer!(roman_i)
          add_buffer
        end

        it 'returns the added tokens' do
          expect(add_buffer).to eq([roman_i, roman_v])
        end

        it 'Line.accumulate is equal 4' do
          expect(line.accumulate).to eq(4)
        end
      end

      context 'and push a smaller roman number' do
        let(:token) { roman_v }

        before do
          line.add_buffer!(roman_x)
          add_buffer
        end

        it 'returns the added tokens' do
          expect(add_buffer).to eq([roman_x, roman_v])
        end

        it 'Line.accumulate is equal 15' do
          expect(line.accumulate).to eq(15)
        end
      end

      context 'and push a galaxy number' do
        let(:token) { galaxy_number }

        before do
          line.add_buffer!(roman_x)
          add_buffer
        end

        it 'returns the added tokens' do
          expect(add_buffer).to eq([roman_x, galaxy_number])
        end

        it 'Line.accumulate is equal 20' do
          expect(line.accumulate).to eq(20)
        end
      end
    end

    context 'Have three equal Roman number in buffer' do
      context 'and push a the same number' do
        let(:token) { roman_x }

        before do
          line.add_buffer!(roman_x)
          line.add_buffer!(roman_x)
          line.add_buffer!(roman_x)
          add_buffer
        end

        it 'Returns nil' do
          expect(add_buffer).to eq(nil)
        end

        it 'Line.accumulate is equal 30' do
          expect(line.accumulate).to eq(30)
        end
      end
    end

    context 'Have a Roman number in buffer and push an invalid roman number' do
      let(:token) { roman_x }

      before do
        line.add_buffer!(roman_i)
        add_buffer
      end

      it 'Returns nil' do
        expect(add_buffer).to eq(nil)
      end

      it 'Line.accumulate is equal 1' do
        expect(line.accumulate).to eq(1)
      end
    end
  end
end
