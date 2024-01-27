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
end