# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'Line' do
  let(:roman_i) { Token.new('I', 1) }
  let(:roman_v) { Token.new('V', 5) }
  let(:roman_x) { Token.new('X', 10) }
  let(:galaxy_number) { Token.new('glub', 2) }

  describe '.push' do
    context 'Tokens is empty and push some token' do
      subject { Line.new }

      before do
        subject.push(roman_x)
      end

      it 'Line.tokens is not empty' do
        expect(subject.tokens).not_to be_empty
      end

      it 'Line.tokens have exaclty 1 token' do
        expect(subject.tokens).to have_exactly(1).tokens
      end

      it 'Line.tokens include X roman ' do
        expect(subject.tokens).to include(roman_x)
      end
    end

    context 'Tokens is not empty and push some token' do
      subject { Line.new }

      before do
        subject.push(roman_i)
        subject.push(roman_x)
      end

      it 'Line.tokens is not empty' do
        expect(subject.tokens).not_to be_empty
      end

      it 'Line.tokens have exaclty 2 tokens' do
        expect(subject.tokens).to have_exactly(2).tokens
      end

      it 'Line.tokens include X roman ' do
        expect(subject.tokens).to include(roman_x)
      end

      it 'Line.tokens include I roman ' do
        expect(subject.tokens).to include(roman_i)
      end
    end
  end

  describe '.add_buffer' do
    context 'Tokens is empty and push some token to buffer' do
      subject { Line.new }

      before do
        subject.add_buffer(roman_x)
      end

      it 'Line.tokens is not empty' do
        expect(subject.tokens).not_to be_empty
      end

      it 'Line.tokens have exaclty 1 token' do
        expect(subject.tokens).to have_exactly(1).tokens
      end

      it 'Line.tokens include X roman ' do
        expect(subject.tokens).to include(roman_x)
      end

      it 'Line.accumulate is equal 10' do
        expect(subject.accumulate).to eq(10)
      end
    end

    context 'Have a Roman number in buffer and push a bigger roman number' do
      subject { Line.new }

      before do
        subject.add_buffer(roman_i)
        subject.add_buffer(roman_v)
      end

      it 'Line.tokens is not empty' do
        expect(subject.tokens).not_to be_empty
      end

      it 'Line.tokens have exaclty 2 token' do
        expect(subject.tokens).to have_exactly(2).tokens
      end

      it 'Line.tokens include I roman ' do
        expect(subject.tokens).to include(roman_i)
      end

      it 'Line.tokens include V roman ' do
        expect(subject.tokens).to include(roman_v)
      end

      it 'Line.accumulate is equal 4' do
        expect(subject.accumulate).to eq(4)
      end
    end

    context 'Have a Roman number in buffer and push a smaller roman number' do
      subject { Line.new }

      before do
        subject.add_buffer(roman_x)
        subject.add_buffer(roman_v)
      end

      it 'Line.tokens is not empty' do
        expect(subject.tokens).not_to be_empty
      end

      it 'Line.tokens have exaclty 2 token' do
        expect(subject.tokens).to have_exactly(2).tokens
      end

      it 'Line.tokens include X roman ' do
        expect(subject.tokens).to include(roman_x)
      end

      it 'Line.tokens include V roman ' do
        expect(subject.tokens).to include(roman_v)
      end

      it 'Line.accumulate is equal 15' do
        expect(subject.accumulate).to eq(15)
      end
    end

    context 'Have a Roman number in buffer and push a galaxy number' do
      subject { Line.new }

      before do
        subject.add_buffer(roman_x)
        subject.add_buffer(galaxy_number)
      end

      it 'Line.tokens is not empty' do
        expect(subject.tokens).not_to be_empty
      end

      it 'Line.tokens have exaclty 2 token' do
        expect(subject.tokens).to have_exactly(2).tokens
      end

      it 'Line.tokens include X roman ' do
        expect(subject.tokens).to include(roman_x)
      end

      it 'Line.tokens include Glub roman ' do
        expect(subject.tokens).to include(galaxy_number)
      end

      it 'Line.accumulate is equal 20' do
        expect(subject.accumulate).to eq(20)
      end
    end

    context 'Have three equal Roman number in buffer and push a the same number' do
      subject { Line.new }

      before do
        subject.add_buffer(roman_x)
        subject.add_buffer(roman_x)
        subject.add_buffer(roman_x)
      end

      it 'Line.tokens is not empty' do
        expect(subject.tokens).not_to be_empty
      end

      it 'Line.tokens have exaclty 3 token' do
        expect(subject.tokens).to have_exactly(3).tokens
      end

      it 'Line.accumulate is equal 30' do
        expect(subject.accumulate).to eq(30)
      end
    end

    context 'Have a Roman number in buffer and push an invalid roman number' do
      subject { Line.new }

      before do
        subject.add_buffer(roman_i)
        subject.add_buffer(roman_x)
      end

      it 'Line.tokens is not empty' do
        expect(subject.tokens).not_to be_empty
      end

      it 'Line.tokens have exaclty 1 token' do
        expect(subject.tokens).to have_exactly(1).tokens
      end

      it 'Line.tokens include I roman ' do
        expect(subject.tokens).to include(roman_i)
      end

      it 'Line.tokens not include X roman ' do
        expect(subject.tokens).not_to include(roman_x)
      end

      it 'Line.accumulate is equal 1' do
        expect(subject.accumulate).to eq(1)
      end
    end
  end
end
