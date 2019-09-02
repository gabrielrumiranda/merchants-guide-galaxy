require_relative '../../app/calculator.rb'

RSpec.describe 'Calculator' do
  describe '.calculate' do
    subject { Calculator.new('glob prok')}

    it 'Returns 3' do
      subject.calculate
      expect(subject.line.accumulate).to eq(3)
    end
  end
end
