require_relative '../../app/calculator.rb'

RSpec.describe 'Calculator' do
  describe '.calculate' do
    context 'File input test' do
      subject { Calculator.new()}

      it 'Returns 42' do
        subject.read('/Users/gabrielrumiranda/Documents/merchants-guide-galaxy/spec/app/test.txt')
        expect(subject.line.accumulate).to eq(42)
      end
    end

  end
end
