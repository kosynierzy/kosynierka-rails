require 'spec_helper'

describe RemoveEntryBan do
  subject { described_class.new(user, entry_id) }

  let(:moderator) { create(:user, :moderator) }
  let(:entry) { create(:entry, banned_by: moderator, banned_at: Time.now) }
  let(:entry_id) { entry.id }

  describe '#call' do
    describe 'authorization rules' do
      let(:user) { create(:user) }

      it 'fails if user is not a moderator' do
        expect do
          subject.call
        end.to raise_error(PermissionError)
      end
    end

    describe 'valid process' do
      before do
        subject.call
        entry.reload
      end

      let(:user) { moderator }

      it 'removes ban from entry' do
        expect(entry.banned?).to eq(false)
      end

      it 'forgets who made a ban' do
        expect(entry.banned_by).to be_nil
      end

      it 'forgets when ban was made' do
        expect(entry.banned_at).to be_nil
      end
    end
  end
end
