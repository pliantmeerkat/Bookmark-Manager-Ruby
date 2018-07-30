feature 'Visible List of Bookmarks' do
  scenario 'Home page displays list of bookmarks' do
    visit('/')
    expect(page).to have_content('Bookmarks')
  end
end
