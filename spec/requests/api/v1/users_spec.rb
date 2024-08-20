require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:user) { create(:user, email: "user@example.com") }
  let!(:token) { Doorkeeper::AccessToken.create(resource_owner_id: user.id).token }

  before do
    request.headers['Authorization'] = "Bearer #{token}"
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:params) { { user: { email: 'test@example.com', password: 'password123' } } }

      it 'creates a new user' do
        expect do
          post :create, params: params
        end.to change(User, :count).by(1)
      end

      it 'returns a created status' do
        post :create, params: params
        expect(response).to have_http_status(:created)
      end

      it 'returns the newly created user' do
        post :create, params: params
        expect(JSON.parse(response.body)).to have_key('data')
        expect(JSON.parse(response.body)['data']['attributes']['email']).to eq('test@example.com')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { user: { email: 'invalid_email', password: '' } } }

      it 'does not create a new user' do
        expect do
          post :create, params: invalid_params
        end.not_to change(User, :count)
      end

      it 'returns unprocessable entity status' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
