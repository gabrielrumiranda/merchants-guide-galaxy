require_relative '../spec_helper'
RSpec.describe 'Dictionary' do
  describe '.add_word' do
    context 'Words is empty and add some word' do
      subject { Dictionary.new }

      it 'Returns an hash with one element' do
        subject.add_word('Plact', 52)
        expect(subject.words).not_to be_empty
        expect(subject.words).to include('Plact' => 52)
        expect(subject).to have_exactly(1).words
      end
    end

    context 'Words is not empty and add some word' do
      subject { Dictionary.new }

      before(:example) do
        subject.add_word('Plact', 52)
      end

      it 'Returns an hash with one element' do
        subject.add_word('Zum', 30)
        expect(subject.words).not_to be_empty
        expect(subject.words).to include('Plact' => 52)
        expect(subject.words).to include('Zum' => 30)
        expect(subject).to have_exactly(2).words
      end
    end
  end
end
