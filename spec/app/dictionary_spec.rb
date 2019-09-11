require_relative '../spec_helper'
RSpec.describe 'Dictionary' do
  describe '.add_word' do

    context 'Words is empty and add some word' do
      subject { Dictionary.new }
      before { subject.add_word('Plact', 52) }

      it 'Dictionary.words is not empty' do
        expect(subject.words).not_to be_empty
      end

      it 'Dictionary.words include (Plact => 52)' do
        expect(subject.words).to include('Plact' => 52)
      end

      it 'Dictionary.words have exaclty 1 word' do
        expect(subject).to have_exactly(1).words
      end
    end

    context 'Words is not empty and add some word' do
      subject { Dictionary.new }

      before do
        subject.add_word('Plact', 52)
        subject.add_word('Zum', 30)
      end

      it 'Dictionary.words is not empty' do
        expect(subject.words).not_to be_empty
      end

      it 'Dictionary.words include (Plact => 52)' do
        expect(subject.words).to include('Plact' => 52)
      end

      it 'Dictionary.words include (Zum => 30)' do
        expect(subject.words).to include('Zum' => 30)
      end

      it 'Dictionary.words have exaclty 2 word' do
        expect(subject).to have_exactly(2).words
      end
    end
  end
end
