require 'spec_helper'

describe CreateEntryForm do
  describe '.new' do
    it 'raises error when unknown field passed' do
      expect do
        described_class.new({content: 'Content', unknown: 'Something'})
      end.to raise_error(UnknownFieldError, 'unknown given, but not declared in the form.')
    end

    it 'assigns attributes' do
      form = described_class.new({content: 'Content'})
      expect(form.content).to eq('Content')
    end
  end

  describe '#validate!' do
    it 'raises error when content missing' do
      expect do
        form = described_class.new({content: ''})
        form.validate!
      end.to raise_error(ValidationError)
    end
  end
end
