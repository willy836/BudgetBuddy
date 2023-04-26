require 'rails_helper'

RSpec.feature 'categories#index', type: :feature do
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
    category.image.attach(blob)
    sign_in user
  end

  scenario 'viewing categories index page' do
    visit categories_path

    expect(page).to have_selector('h1', text: 'CATEGORIES')

    within('.categories-section') do
      if Category.count == 0
        expect(page).to have_content('Add your first category')
      else
        expect(page).to have_selector('.categories-container')

        within('.categories-container') do
          Category.all.each do |_category|
            expect(page).to have_selector('img')
          end
        end

        expect(page).to have_selector('button')
        expect(page).to have_link('Add New Category', href: new_category_path)
      end
    end
  end

  scenario 'adding a new category' do
    visit categories_path

    click_link 'Add New Category'

    expect(page).to have_current_path(new_category_path)
  end
end
