require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :controller do
  let(:category) { create(:category) }
  let(:courses_attributes) do
    [{ name: 'Ruby on Rails', author: 'David Heinemeier Hansson', state: 'active' },
     { name: 'JavaScript Basics', author: 'John Doe', state: 'inactive' }]
  end
  let(:user) { create(:user, email: "user@example.com") }
  let!(:token) { Doorkeeper::AccessToken.create(resource_owner_id: user.id).token }

  before do
    request.headers['Authorization'] = "Bearer #{token}"
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
      get :search, params: { query: category.name }
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: category.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let(:params) { { category: { name: 'New Category', vertical_id: create(:vertical).id } } }

    it 'creates a new category' do
      expect do
        post :create, params: params
      end.to change(Category, :count).by(1)
    end

    it 'returns a created status' do
      post :create, params: params
      expect(response).to have_http_status(:created)
    end

    it 'returns the newly created category' do
      post :create, params: params
      expect(JSON.parse(response.body)).to have_key('data')
      expect(JSON.parse(response.body)['data']['attributes']['name']).to eq('New Category')
    end
  end

  describe 'POST #create with nested attributes' do
    let(:vertical) { create(:vertical) }
    let(:params) do
      {
        category: {
          name: 'Programming',
          vertical_id: vertical.id,
          state: 'active',
          courses_attributes: courses_attributes
        }
      }
    end

    it 'creates a new vertical with categories' do
      expect do
        post :create, params: params
      end.to change(Category, :count).by(1).and change(Course, :count).by(2)
    end

    it 'returns a created status' do
      post :create, params: params
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PUT #update' do
    let(:new_name) { 'Updated Category' }

    it 'updates the category' do
      put :update, params: { id: category.id, category: { name: new_name } }
      category.reload
      expect(category.name).to eq(new_name)
    end

    it 'returns a successful status' do
      put :update, params: { id: category.id, category: { name: new_name } }
      category.reload
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT #update with nested attributes' do
    let(:vertical) { create(:vertical) }
    let(:category) { create(:category, name: "Programming", vertical: vertical) }
    let(:course) { create(:course, category: category, name: 'Ruby on Rails', author: 'DHH', state: 'active') }

    let(:update_params) do
      {
        id: category.id,
        category: {
          name: 'Web Development',
          vertical_id: vertical.id,
          state: 'active',
          courses_attributes: [
            { id: course.id, name: 'Updated Ruby on Rails', author: 'DHH', state: 'active' },
            { name: 'JavaScript Advanced', author: 'John Doe', state: 'inactive' }
          ]
        }
      }
    end

    it 'updates the vertical and nested categories' do
      put :update, params: update_params
      category.reload
      expect(category.name).to eq('Web Development')
    end

    it 'returns a successful status' do
      put :update, params: update_params
      category.reload
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE #destroy' do
    let!(:category) { create(:category) }
    it 'destroys the category' do
      expect do
        delete :destroy, params: { id: category.id }
      end.to change(Category, :count).by(-1)
    end

    it 'returns a no content status' do
      delete :destroy, params: { id: category.id }
      expect(response).to have_http_status(:no_content)
    end
  end
end
