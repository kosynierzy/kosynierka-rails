require 'spec_helper'

describe CreateEntry do
  subject { described_class.new(user, form) }

  let(:user) { create(:user) }
  let(:form) { CreateEntryForm.new({content: content}) }

  describe '#call' do
    context 'when missing content' do
      let(:content) { '' }

      it 'raises validation error' do
        expect do
          subject.call
        end.to raise_error(ValidationError)
      end
    end

    context 'when valid form' do
      let(:content) { 'Content message' }

      it 'returns new entry' do
        result = subject.call
        expect(result).to be_a(Entry)
        expect(result.content).to eq('Content message')
        expect(result.content_html).to eq("<p>Content message</p>\n")
      end

      it 'creates user entry' do
        expect do
          subject.call
        end.to change { user.entries.count }.by(1)
      end

      it 'yields entry' do
        expect { |entry| subject.call(&entry) }.to yield_with_args(Entry)
      end
    end
  end
end
