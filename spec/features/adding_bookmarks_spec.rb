feature 'Adding Bookmarks' do
  before(:each) do
    visit '/'
  end
  scenario 'User can add a bookmark' do
    new_bookmark = 'https://en.wikipedia.org/wiki/Capybara'
    expect(page).to_not have_content(new_bookmark)
    click_button('Add')
    fill_in('Bookmark', with: new_bookmark)
    click_button('Enter')
    expect(page).to have_content('Bookmark Added')
    expect(page).to have_content(new_bookmark)
  end
  scenario 'Cannot add bookmark if url invalid' do
    click_button('Add')
    fill_in('Bookmark', with: 'hello world')
    click_button('Enter')
    expect(page).to have_content('Invalid Url')
  end
end
