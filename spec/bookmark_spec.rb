require './model/bookmark'
require 'web_helper'
describe Bookmark do
  let(:subject) { described_class.new }
  describe '#.all' do
    let(:connection) { PG.connect(dbname: 'bookmark_manager_test') }
    it 'returns all bookmarks in db' do
      3.times do |i|
        connection.exec("INSERT INTO bookmarks (url) VALUES('#{test_bookmarks[i]}');")
      end
      expect(Bookmark.all).to eq(test_bookmarks)
    end
  end
  describe '#.add_bookmark' do
    it { expect(Bookmark).to respond_to(:add_bookmark).with(1).arguments }
    it 'can add a bookmark to the data base' do
      new_bookmark = 'https://en.wikipedia.org/wiki/Capybara'
      Bookmark.add_bookmark(new_bookmark)
      expect(Bookmark.all.last).to eq(new_bookmark)
    end
    it 'raises error with bad input' do
      expect(Bookmark.add_bookmark('hello')).to eq('INVALID')
    end
  end
  describe 'connects to non-test db in env regular' do
    after(:each) { ENV['ENVIRONMENT'] = 'test' }
    it 'can conncet to non test db' do
      ENV['ENVIRONMENT'] = 'dev'
      expect(
        Bookmark.connection_set.exec('SELECT * FROM current_catalog').map { |b| b['current_catalog']}.join
      ).to eq('bookmark_manager')
    end
  end
end
