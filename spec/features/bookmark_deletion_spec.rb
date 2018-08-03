feature 'Bookmark deletion' do
  before(:each) { visit('/') }
  scenario 'User can delete a bookmark if valid url' do
    add_test_bookmarks_to_db
    click_button('Remove')
    expect(page).to have_content('Enter a bookmark title to delete')
    fill_in('Bookmark', with: 'Google')
    click_button('Confirm')
    expect(page).to_not have_content('Google')
    expect(page).to have_content('Bookmark Deleted')
  end
  scenario 'User cannot delete bookmark not in databasae' do
    click_button('Remove')
    fill_in('Bookmark', with: 'Google')
    click_button('Confirm')
    expect(page).to have_content('Bookmark not in database')
  end
  scenario 'User can Clear bookmarks' do
    add_test_bookmarks_to_db
    click_button('Clear')
    test_bookmarks.each { |b| expect(page).to_not have_content(b[:title]) }
    expect(page).to have_content('Bookmarks Cleared')
  end
end
