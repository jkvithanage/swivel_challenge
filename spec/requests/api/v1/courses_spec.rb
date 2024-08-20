require 'rails_helper'

RSpec.describe Api::V1::CoursesController, type: :controller do
  let(:course) { create(:course) }
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
      get :search, params: { query: course.name }
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: course.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let(:params) { { course: { name: 'New Course', author: 'John Doe', category_id: create(:category).id } } }

    it 'creates a new course' do
      expect do
        post :create, params: params
      end.to change(Course, :count).by(1)
    end

    it 'returns the newly created course' do
      post :create, params: params
      expect(JSON.parse(response.body)).to have_key('data')
      expect(JSON.parse(response.body)['data']['attributes']['name']).to eq('New Course')
    end
  end

  describe 'PUT #update' do
    let(:new_name) { 'Updated Course' }

    it 'updates the course' do
      put :update, params: { id: course.id, course: { name: new_name } }
      course.reload
      expect(course.name).to eq(new_name)
    end
  end

  describe 'DELETE #destroy' do
    let!(:course) { create(:course) }
    it 'destroys the course' do
      expect do
        delete :destroy, params: { id: course.id }
      end.to change(Course, :count).by(-1)
    end

    it 'returns a no content status' do
      delete :destroy, params: { id: course.id }
      expect(response).to have_http_status(:no_content)
    end
  end
end
