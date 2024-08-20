require 'rails_helper'

RSpec.describe Api::V1::SearchController, type: :controller do
  let(:user) { create(:user, email: "user@example.com") }
  let!(:token) { Doorkeeper::AccessToken.create(resource_owner_id: user.id).token }

  before do
    request.headers['Authorization'] = "Bearer #{token}"
  end

  describe 'GET #search' do
    context 'with a valid query' do
      it 'returns a successful response' do
        get :search, params: { query: 'test' }
        expect(response).to be_successful
      end

      it 'returns search results' do
        get :search, params: { query: 'test' }
        expect(JSON.parse(response.body)).to have_key('data')
      end
    end

    context 'with a blank query' do
      it 'returns a bad request status' do
        get :search, params: { query: '' }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with sorting' do
      it 'applies the correct sorting' do
        get :search, params: { query: 'test', sort: 'created_at' }
        expect(response).to be_successful
      end
    end
  end
end
