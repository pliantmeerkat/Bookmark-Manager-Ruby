feature 'Visible List of Bookmarks' do
  scenario 'Home page displays list of bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    3.times do |i|
      connection.exec("INSERT INTO bookmarks (url) VALUES('#{test_bookmarks[i]}');")
    end
    visit('/')
    test_bookmarks.each { |b| expect(page).to have_content(b) }
  end
end
