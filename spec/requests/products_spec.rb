require 'rails_helper'

RSpec.describe ProductsController, type: :request do
    describe 'GET /new' do
        let(:user) { User.create!(name: 'Jane Doe', email: 'janedoe@gmail.com', password: 'jane123') }
        let(:category) { Category.create!(name: 'Test Category', user_id: user.id) }
        before { sign_in user }
      
      before { get new_category_product_path(category_id: category.id) }
  
      it 'returns http status success' do
        expect(response).to have_http_status(:success)
      end
  
      it 'renders new template' do
        expect(response).to render_template(:new)
      end
    end
  end
  
