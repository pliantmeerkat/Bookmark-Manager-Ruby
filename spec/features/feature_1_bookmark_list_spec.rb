feature 'Visible List of Bookmarks' do
  scenario 'Home page displays list of bookmarks' do
    add_test_bookmarks_to_db
    visit('/')
    test_bookmarks.each { |b| expect(page).to have_content(b[:title]) }
  end
end
