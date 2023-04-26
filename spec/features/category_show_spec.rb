require 'rails_helper'

RSpec.feature 'category#show', type: :feature do
  let(:image_file) do
    fixture_file_upload('C:/Users/Willy/Desktop/RAILS/BudgetBuddy/spec/fixtures/files/test_image.jpg', 'image/jpeg')
  end
  let(:user) { User.create!(name: 'Jane Doe', email: 'janedoe@gmail.com', password: 'jane123') }
  let(:category) { user.categories.create(name: 'Test Category', image: image_file) }
  let(:blob) do
    ActiveStorage::Blob.create_and_upload!(
      io: File.open('C:/Users/Willy/Desktop/RAILS/BudgetBuddy/spec/fixtures/files/test_image.jpg'),
      filename: 'test_image.jpg', content_type: 'image/jpeg'
    )
  end
  let(:transaction1) { category.products.create!(name: 'Transaction 1', amount: 100, user:) }
  let(:transaction2) { category.products.create!(name: 'Transaction 2', amount: 50, user:) }

  before do
    category.image.attach(blob)
    sign_in user
  end

  scenario 'viewing categories show page' do
    visit category_path(category)
    expect(page).to have_selector('h1', text: 'TRANSACTIONS')

    within('.transactions-section') do
      expect(page).to have_content(category.name.capitalize)
      expect(page).to have_content("$ #{category.total_amount}")
      expect(page).to have_content(category.created_at.strftime('%m/%d/%Y'))

      expect(page).to have_selector('a.back-link', text: 'Back')
      expect(page).to have_selector('a.add-product-link', text: 'Add Transaction')

      if Product.count == 0
        expect(page).to have_content('')
      else
        expect(page).to have_selector('article.transaction', count: 2)
        expect(page).to have_content(transaction1.name.capitalize)
        expect(page).to have_content("$ #{transaction1.amount}")
        expect(page).to have_content(transaction2.name.capitalize)
        expect(page).to have_content("$ #{transaction2.amount}")
      end
    end
  end
end
