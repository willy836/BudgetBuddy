require 'rails_helper'

RSpec.feature 'products#new', type: :feature do
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

  before do
    sign_in user
  end

  scenario 'viewing products new page' do
    visit new_category_product_path(category)

    expect(page).to have_selector('h1', text: 'ADD TRANSACTION')
    expect(page).to have_selector('form')
    expect(page).to have_selector('form label', text: 'Name')
    expect(page).to have_selector('form input[type="text"][name="product[name]"]')
    expect(page).to have_selector('form label', text: 'Amount')
    expect(page).to have_selector('form input[type="number"][name="product[amount]"]')
    expect(page).to have_selector('label', text: 'Select Category/ Categories')
    expect(page).to have_selector('input[type="checkbox"][name="product[category_ids][]"]', count: Category.count)
    expect(page).to have_selector('input[type="submit"][value="Save"]')
    expect(page).to have_selector('button.new-transaction-back-btn')
    expect(page).to have_link('Back', href: category_path(category))
  end
end
