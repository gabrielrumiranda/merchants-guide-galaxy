# frozen_string_literal: true
require_relative '../spec_helper'

RSpec.describe 'Line' do
  describe '.push' do
    context 'Tokens is empty and push some token' do
      subject { Line.new }

      it 'Returns an array with one token' do
        token = Token.new('X', 10)
        subject.push(token)
        expect(subject.tokens).not_to be_empty
        expect(subject.tokens).to include(token)
        expect(subject).to have_exactly(1).tokens
      end
    end

    context 'Tokens is not empty and push some token' do
      subject { Line.new }

      before do
        token = Token.new('I', 1)
        subject.push(token)
      end

      it 'Returns an array with two tokens' do
        token = Token.new('X', 10)
        subject.push(token)
        expect(subject.tokens).not_to be_empty
        expect(subject.tokens).to include(token)
        expect(subject).to have_exactly(2).tokens
      end
    end
  end

  describe '.add_buffer' do
    context 'Tokens is empty and push some token to buffer' do
      subject { Line.new }

      it 'Returns an array with one token and accumulate equal 10' do
        token = Token.new('X', 10)
        subject.add_buffer(token)
        expect(subject.tokens).not_to be_empty
        expect(subject.tokens).to include(token)
        expect(subject).to have_exactly(1).tokens
        expect(subject.accumulate).to eq(10)
      end
    end

    context 'Have a Roman number in buffer and push a bigger roman number' do
      subject { Line.new }

      before do
        token = Token.new('I', 1)
        subject.add_buffer(token)
      end

      it 'Returns an array with two tokens and accumulate equal 4' do
        token = Token.new('V', 5)
        subject.add_buffer(token)
        expect(subject.tokens).not_to be_empty
        expect(subject.tokens).to include(token)
        expect(subject).to have_exactly(2).tokens
        expect(subject.accumulate).to eq(4)
      end
    end

    context 'Have a Roman number in buffer and push a smaller roman number' do
      subject { Line.new }

      before do
        token = Token.new('X', 10)
        subject.add_buffer(token)
      end

      it 'Returns an array with two tokens and accumulate equal 15' do
        token = Token.new('V', 5)
        subject.add_buffer(token)
        expect(subject.tokens).not_to be_empty
        expect(subject.tokens).to include(token)
        expect(subject).to have_exactly(2).tokens
        expect(subject.accumulate).to eq(15)
      end
    end

    context 'Have a Roman number in buffer and push a galaxy number' do
      subject { Line.new }

      before do
        token = Token.new('X', 10)
        subject.add_buffer(token)
      end

      it 'Returns an array with two tokens and accumulate equal 20' do
        token = Token.new('glub', 2)
        subject.add_buffer(token)
        expect(subject.tokens).not_to be_empty
        expect(subject.tokens).to include(token)
        expect(subject).to have_exactly(2).tokens
        expect(subject.accumulate).to eq(20)
      end
    end

    context 'Have three equal Roman number in buffer and push a the same number' do
      subject { Line.new }

      before do
        token = Token.new('X', 10)
        subject.add_buffer(token)
        subject.add_buffer(token)
        subject.add_buffer(token)
      end

      it 'Returns an array with three tokens and accumulate equal 30 and not have the fourth token' do
        token = Token.new('X', 10)
        subject.add_buffer(token)
        expect(subject.tokens).not_to be_empty
        expect(subject.tokens). not_to include(token)
        expect(subject).to have_exactly(3).tokens
        expect(subject.accumulate).to eq(30)
      end
    end

    context 'Have a Roman number in buffer and push an invalid roman number' do
      subject { Line.new }

      before do
        token = Token.new('X', 10)
        subject.add_buffer(token)
      end

      it 'Returns an array with one token and accumulate equal 10 and not have the second token' do
        token = Token.new('M', 1000)
        subject.add_buffer(token)
        expect(subject.tokens).not_to be_empty
        expect(subject.tokens). not_to include(token)
        expect(subject).to have_exactly(1).tokens
        expect(subject.accumulate).to eq(10)
      end
    end
  end
end
