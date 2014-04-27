require 'spec_helper'

describe BanEntry do
  subject { described_class.new(user, entry_id) }

  let(:entry) { create(:entry) }
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

      let(:user) { create(:user, :moderator) }

      it 'bans entry' do
        expect(entry.banned?).to eq(true)
      end

      it 'remembers who made a ban' do
        expect(entry.banned_by).to eq(user)
      end

      it 'remembers when ban was made' do
        expect(entry.banned_at).not_to be_nil
      end
    end
  end
end
