feature 'Adding Bookmarks' do
  before(:each) do
    visit '/'
  end
  scenario 'User can add a bookmark' do
    expect(page).to_not have_content('Capybara')
    click_button('Add')
    fill_in('Bookmark', with: 'https://en.wikipedia.org/wiki/Capybara')
    fill_in('title', with: 'Capybara')
    click_button('Enter')
    expect(page).to have_content('Bookmark Added')
    expect(page).to have_content('Capybara')
  end
  scenario 'Cannot add bookmark if url invalid' do
    click_button('Add')
    fill_in('Bookmark', with: 'hello world')
    click_button('Enter')
    expect(page).to have_content('Invalid Url')
  end
end
