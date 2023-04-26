require 'rails_helper'

RSpec.describe CategoriesController, type: :request do
    describe 'GET /index' do
        let(:user) { User.create(name: 'John Doe', email: 'johndoe@gmail.com', password: 'john123') }
    
        before { sign_in user }
    
        it 'returns http success' do
          get categories_path
          expect(response).to have_http_status(:success)
        end
    
        it 'renders index template' do
          get categories_path
          expect(response).to render_template(:index)
        end
      end

    describe 'GET /show' do
        let(:image_file) { fixture_file_upload('C:/Users/Willy/Desktop/RAILS/BudgetBuddy/spec/fixtures/files/test_image.jpg', 'image/jpeg') }
        
        let(:user) { User.create!(name: 'Jane Doe', email: 'janedoe@gmail.com', password: 'jane123') }
        let(:category) { user.categories.create(name: 'Test Category', image: image_file) }
        let(:blob) { ActiveStorage::Blob.create_and_upload!(io: File.open('C:/Users/Willy/Desktop/RAILS/BudgetBuddy/spec/fixtures/files/test_image.jpg'), filename: 'test_image.jpg', content_type: 'image/jpeg') }
      
        before do
          category.image.attach(blob)
          sign_in user
        end
      
        it 'returns http success' do
          get category_path(category.id)
          expect(response).to have_http_status(:success)
        end
      
        it 'renders show template' do
          get category_path(category.id)
          expect(response).to render_template(:show)
        end
      
        it 'displays category image' do
          get category_path(category.id)
          expect(response.body).to include('img')
        end
      end
end