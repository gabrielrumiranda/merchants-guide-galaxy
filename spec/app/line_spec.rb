# frozen_string_literal: true

require_relative '../../app/line.rb'
require_relative '../../app/token.rb'
RSpec.describe 'Line' do
  describe '.push' do
    context 'Tokens is empty and push some token' do
      subject { Line.new }

      it 'Returns an array with one token' do
        token = Token.new('X', 10)
        subject.push(token)
        expect(subject.tokens).not_to be_empty
        expect(subject.tokens).to include(token)
      end
    end
  end
end
