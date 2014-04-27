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

  describe '#seen?' do
    context 'for guest' do
      it 'returns true' do
        entry = create(:entry)
        expect(entry.seen?(nil)).to eq(true)
      end
    end

    context 'for user' do
      let(:user) { create(:user, last_seen_entry: last_seen_entry) }
      let(:last_seen_entry) { create(:entry) }

      it 'returns true if user seen newer entry already' do
        Delorean.time_travel_to("1 day ago")
        entry = create(:entry)
        Delorean.back_to_the_present

        expect(entry.seen?(user)).to eq(true)
      end

      it 'returns false if user last seen entry is older' do
        Delorean.time_travel_to("tomorrow")
        entry = create(:entry)
        Delorean.back_to_the_present

        expect(entry.seen?(user)).to eq(false)
      end

      it 'returns true if last seen entry is the current entry' do
        expect(last_seen_entry.seen?(user)).to eq(true)
      end
    end
  end
end
