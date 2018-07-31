feature 'Visible List of Bookmarks' do
  before(:each) { visit('/') }
  scenario 'Home page displays list of bookmarks' do
    expect(page).to have_content('Bookmarks')
    expect(page).to have_content 'https://www.google.com/'
    expect(page).to have_content 'https://github.com/'
  end
end
