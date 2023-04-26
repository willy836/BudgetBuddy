require 'rails_helper'

RSpec.feature 'categories#new', type: :feature do
  let(:user) { User.create!(name: 'Jane Doe', email: 'janedoe@gmail.com', password: 'jane123') }

  before do
    sign_in user
  end

  scenario 'viewing categories new page' do
    visit new_category_path

    expect(page).to have_selector('h1', text: 'NEW CATEGORY')
    expect(page).to have_selector('form')
    expect(page).to have_selector('form label', text: 'Name')
    expect(page).to have_selector('form input[type="text"][name="category[name]"]')
    expect(page).to have_selector('p', text: 'Upload an image')
    expect(page).to have_selector('form input[type="file"][name="category[image]"]')
    expect(page).to have_selector('form input[type="submit"][value="Save"]')
    expect(page).to have_selector('button.new-cat-back-btn a.new-cat-back-link', text: 'Back')
  end
end
