require 'rails_helper'

RSpec.describe Api::V1::VerticalsController, type: :controller do
  let(:vertical) { create(:vertical) }
  let(:category_attributes) { [{ name: 'Category 1', state: 'active' }, { name: 'Category 2', state: 'inactive' }] }

  let(:user) { create(:user) }
  let!(:token) { Doorkeeper::AccessToken.create(resource_owner_id: user.id).token }

  before do
    request.headers['Authorization'] = "Bearer #{token}"
    request.headers['Content-Type'] = 'application/json'
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'returns paginated results' do
      get :index
      expect(JSON.parse(response.body)).to have_key('meta')
    end
  end

  describe 'GET #search' do
    it 'returns search results' do
      get :search, params: { query: vertical.name }
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: vertical.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let(:params) { { vertical: { name: 'New Vertical' } } }

    it 'creates a new vertical' do
      expect do
        post :create, params: params
      end.to change(Vertical, :count).by(1)
    end

    it 'returns a created status' do
      post :create, params: params
      expect(response).to have_http_status(:created)
    end

    it 'returns the newly created vertical' do
      post :create, params: params
      expect(JSON.parse(response.body)).to have_key('data')
      expect(JSON.parse(response.body)['data']['attributes']['name']).to eq('New Vertical')
    end
  end

  describe 'POST #create with nested attributes' do
    let(:params) do
      {
        vertical: {
          name: 'Parent Vertical',
          categories_attributes: category_attributes
        }
      }
    end

    it 'creates a new vertical with categories' do
      expect do
        post :create, params: params
      end.to change(Vertical, :count).by(1).and change(Category, :count).by(2)
    end

    it 'returns a created status' do
      post :create, params: params
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PUT #update' do
    let(:new_name) { 'Updated Vertical' }

    it 'updates the vertical' do
      put :update, params: { id: vertical.id, vertical: { name: new_name } }
      vertical.reload
      expect(vertical.name).to eq(new_name)
    end

    it 'returns a successful status' do
      put :update, params: { id: vertical.id, vertical: { name: new_name } }
      vertical.reload
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT #update with nested attributes' do
    let(:vertical) { create(:vertical, name: "Bike") }
    let(:category) { create(:category, vertical: vertical, name: 'Mountain Bike', state: 'active') }

    let(:update_params) do
      {
        id: vertical.id,
        vertical: {
          name: 'Updated Bike',
          categories_attributes: [
            { id: category.id, name: 'Updated Mountain Bike', state: 'active' }
          ]
        }
      }
    end

    it 'updates the vertical and nested categories' do
      put :update, params: update_params
      vertical.reload
      expect(vertical.name).to eq('Updated Bike')
    end

    it 'returns a successful status' do
      put :update, params: update_params
      vertical.reload
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE #destroy' do
    let!(:vertical) { create(:vertical) }
    it 'destroys the vertical' do
      expect do
        delete :destroy, params: { id: vertical.id }
      end.to change(Vertical, :count).by(-1)
    end

    it 'returns a no content status' do
      delete :destroy, params: { id: vertical.id }
      expect(response).to have_http_status(:no_content)
    end
  end
end
