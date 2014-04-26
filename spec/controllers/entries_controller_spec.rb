require 'spec_helper'

describe EntriesController do
  let(:valid_params) do
    {
      entry: {
        content: 'New content'
      }
    }
  end

  describe 'POST create' do
    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    context 'when user not signed in' do
      let(:user) { nil }

      it 'redirects to sign in action' do
        post :create, valid_params

        expect(response).to redirect_to(sign_in_path)
      end
    end

    context 'when user signed in' do
      let(:user) { create(:user) }

      context 'and valid data was sent' do
        it 'creates new entry' do
          expect do
            post :create, valid_params
          end.to change { user.entries.count }.by(1)
        end

        it 'redirects to timeline' do
          post :create, valid_params

          expect(response).to redirect_to(root_path)
        end

        it 'sets flash message' do
          post :create, valid_params

          expect(flash[:notice]).to eq('Dodano!')
        end
      end

      context 'and invalid data was sent' do
        it 'does not create entry' do
          expect do
            post :create, { entry: { content: '' } }
          end.not_to change { Entry.count }
        end
      end
    end
  end
end
