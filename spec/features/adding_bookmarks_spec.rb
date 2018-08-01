feature 'Adding Bookmarks' do
  before(:each) { visit '/' }
  scenario 'User can add a bookmark' do
    new_bookmark = 'https://en.wikipedia.org/wiki/Capybara'
    click_button('Add')
    fill_in('Bookmark', with: new_bookmark)
    click_button('Enter')
    expect(page).to have_content(new_bookmark)
  end
end
