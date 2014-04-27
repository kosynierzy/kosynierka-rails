require 'spec_helper'

describe Entry do
  describe '#banned?' do
    it 'returns false if entry was not banned' do
      entry = described_class.new
      entry.banned_at = nil
      entry.banned_by = nil

      expect(entry.banned?).to eq(false)
    end

    it 'returns true if entry was banned' do
      user = create(:user)
      entry = described_class.new
      entry.banned_at = Time.now
      entry.banned_by = user

      expect(entry.banned?).to eq(true)
    end
  end
end
