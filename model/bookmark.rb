require 'pg'
# Bookmark class
class Bookmark
  def self.all
    @connection = connection_set
    result = @connection.exec('SELECT * FROM bookmarks')
    result.map { |b| b['url'] }
  end

  def self.add_bookmark(link)
    begin
      raise 'invalid url' if /http/.match(link).nil? || link.length < 10
    rescue 
      return 'INVALID'
    end
    @connection = connection_set
    @connection.exec("INSERT INTO bookmarks (url) VALUES('#{link}');")
  end

  def self.connection_set
    if ENV['ENVIRONMENT'] == 'test'
      PG.connect(dbname: 'bookmark_manager_test')
    else
      PG.connect(dbname: 'bookmark_manager')
    end
  end
end
