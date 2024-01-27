require 'rails_helper'

RSpec.describe V1::ProvidersController, type: :controller do
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
      get :show, params: { id: FactoryBot.create(:provider).id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'assigns the provider' do
      expect(assigns(:provider)).to eq(Provider.first)
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

    it 'assigns the provider' do
      expect(assigns(:provider)).to be_a_new(Provider)
    end
  end

  describe 'POST #create' do
    before do
      sign_in FactoryBot.create(:user)
      post :create, params: { provider: FactoryBot.attributes_for(:provider) }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:found)
    end

    it 'redirects to providers_path' do
      expect(response).to redirect_to(v1_providers_path)
    end

    it 'creates a provider' do
      expect(Provider.count).to eq(1)
    end
  end

  describe 'GET #edit' do
    before do
      sign_in FactoryBot.create(:user)
      get :edit, params: { id: FactoryBot.create(:provider).id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end

    it 'assigns the provider' do
      expect(assigns(:provider)).to eq(Provider.first)
    end
  end

  describe 'PUT #update' do
    before do
      sign_in FactoryBot.create(:user)
      put :update, params: { id: FactoryBot.create(:provider).id, provider: FactoryBot.attributes_for(:provider, name: 'Updated name') }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:found)
    end

    it 'redirects to providers_path' do
      expect(response).to redirect_to(v1_providers_path)
    end

    it 'updates the provider' do
      expect(Provider.first.name).to eq('Updated name')
    end
  end

  describe 'DELETE #destroy' do
    before do
      sign_in FactoryBot.create(:user)
      delete :destroy, params: { id: FactoryBot.create(:provider).id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:found)
    end

    it 'redirects to providers_path' do
      expect(response).to redirect_to(v1_providers_path)
    end

    it 'destroys the provider' do
      expect(Provider.count).to eq(0)
    end
  end
end