require 'pg'
# Bookmark class
class Bookmark
  def self.all
    @connection = connection_set
    result = @connection.exec('SELECT * FROM bookmarks')
    result.map { |b| [b['url'], b['title']] }
  end

  def self.add_bookmark(link, title)
    return 'INVALID' if valid_url?(link) == false
    @connection = connection_set
    @connection.exec("INSERT INTO bookmarks (url, title) VALUES('#{link}', '#{title}');")
  end

  def self.rm_bookmark(title)
    return 'not in db' if @connection.exec("SELECT title FROM bookmarks WHERE title LIKE '#{title}'").map {|p| p }.empty?
    @connection.exec("DELETE FROM bookmarks WHERE title LIKE '#{title}';")
  end

  def self.clear_bookmarks
    @connection.exec('DELETE FROM bookmarks')
  end

  def self.valid_url?(link)
    return false if /http/.match(link).nil? || link.length < 10
    true
  end

  def self.connection_set
    if ENV['ENVIRONMENT'] == 'test'
      PG.connect(dbname: 'bookmark_manager_test')
    else
      PG.connect(dbname: 'bookmark_manager')
    end
  end
end
