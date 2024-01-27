require 'rails_helper'

RSpec.describe V1::BanksController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe 'GET #index' do
    before do
      sign_in FactoryBot.create(:user)
      get :index
    end

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    before do
      sign_in FactoryBot.create(:user)
      get :show, params: { id: FactoryBot.create(:bank).id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'assigns the bank' do
      expect(assigns(:bank)).to eq(Bank.first)
    end
  end

  describe 'GET #new' do
    before do
      sign_in FactoryBot.create(:user)
      get :new
    end

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end

    it 'assigns the bank' do
      expect(assigns(:bank)).to be_a_new(Bank)
    end
  end

  describe 'POST #create' do
    before do
      sign_in FactoryBot.create(:user)
    end

    context 'with valid params' do
      it 'creates a new bank' do
        expect do
          post :create, params: { bank: FactoryBot.attributes_for(:bank) }
        end.to change(Bank, :count).by(1)
      end

      it 'redirects to the index' do
        post :create, params: { bank: FactoryBot.attributes_for(:bank) }
        expect(response).to redirect_to(v1_banks_path)
      end
    end

    context 'with invalid params' do
      it 'does not create a new bank' do
        expect do
          post :create, params: { bank: FactoryBot.attributes_for(:bank, name: nil) }
        end.to change(Bank, :count).by(0)
      end

      it 'renders the new template' do
        post :create, params: { bank: FactoryBot.attributes_for(:bank, name: nil) }
        expect(response).to render_template(:new)
      end
    end

    context 'with invalid params' do
      it 'does not create a new bank' do
        expect do
          post :create, params: { bank: FactoryBot.attributes_for(:bank, name: nil) }
        end.to change(Bank, :count).by(0)
      end

      it 'renders the new template' do
        post :create, params: { bank: FactoryBot.attributes_for(:bank, name: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    before do
      sign_in FactoryBot.create(:user)
      get :edit, params: { id: FactoryBot.create(:bank).id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end

    it 'assigns the bank' do
      expect(assigns(:bank)).to eq(Bank.first)
    end
  end

  describe 'PUT #update' do
    before do
      sign_in FactoryBot.create(:user)
    end

    context 'with valid params' do
      before do
        put :update, params: { id: FactoryBot.create(:bank).id, bank: FactoryBot.attributes_for(:bank, name: 'New Name') }
      end

      it 'updates the bank' do
        expect(Bank.first.name).to eq('New Name')
      end

      it 'redirects to the index' do
        expect(response).to redirect_to(v1_banks_path)
      end
    end

    context 'with invalid params' do
      before do
        put :update, params: { id: FactoryBot.create(:bank).id, bank: FactoryBot.attributes_for(:bank, name: nil) }
      end

      it 'does not update the bank' do
        expect(Bank.first.name).to_not eq(nil)
      end

      it 'renders the edit template' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      sign_in FactoryBot.create(:user)
    end

    context 'with valid params' do
      before do
        delete :destroy, params: { id: FactoryBot.create(:bank).id }
      end

      it 'deletes the bank' do
        expect(Bank.count).to eq(0)
      end

      it 'redirects to the index' do
        expect(response).to redirect_to(v1_banks_path)
      end
    end

    context 'with invalid params' do
      before do
        provider = FactoryBot.create(:provider)
        FactoryBot.create(:bank_account, bank: FactoryBot.create(:bank), provider: provider)

        it 'does not delete the bank if it has bank accounts' do
          expect do
            delete :destroy, params: { id: FactoryBot.create(:bank).id }
          end.to change(Bank, :count).by(0)
        end

        it 'redirects to the index' do
          delete :destroy, params: { id: FactoryBot.create(:bank).id }
          expect(response).to redirect_to(v1_banks_path)
        end
      end
    end
  end
end