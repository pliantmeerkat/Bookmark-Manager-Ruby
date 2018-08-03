# this file contains helper code for the testing suite, including
# test variables and methods
def test_bookmarks
  [{ url: 'https://www.google.com', title: 'Google' },
   { url: 'https://github.com/', title: 'Github' },
   { url: 'https://www.garybusey.com/', title: 'Gary Busey' }]
end

def add_test_bookmarks_to_db
  connection = PG.connect(dbname: 'bookmark_manager_test')
  3.times do |i|
    connection.exec("INSERT INTO bookmarks (url, title) VALUES('#{test_bookmarks[i][:url]}', '#{test_bookmarks[i][:title]}');")
  end
end
