require './model/bookmark'
require 'web_helper'
describe Bookmark do
  let(:subject) { described_class.new }
  describe '.all' do
    let(:connection) { PG.connect(dbname: 'bookmark_manager_test') }
    it 'returns all bookmarks in db' do
      3.times do |i|
        connection.exec("INSERT INTO bookmarks (url) VALUES('#{test_bookmarks[i]}');")
      end
      expect(Bookmark.all).to eq(test_bookmarks)
    end
  end
  describe '#add_bookmark' do
    it { expect(Bookmark).to respond_to(:add_bookmark) }
    it 'can add a bookmark to the data base' do
      new_bookmark = 'https://en.wikipedia.org/wiki/Capybara'
      Bookmark.add_bookmark(new_bookmark)
      expect(Bookmark.all.last).to eq(new_bookmark)
    end
  end
end
