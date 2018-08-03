require './model/bookmark'
require 'web_helper'
describe Bookmark do
  let(:subject) { described_class.new }
  let(:bmark)  { 'https://en.wikipedia.org/wiki/Capybara' }
  describe '#.all' do
    let(:connection) { PG.connect(dbname: 'bookmark_manager_test') }
    it 'returns all bookmarks in db' do
      add_test_bookmarks_to_db
      expect(Bookmark.all).to eq(test_bookmarks.map { |i| i.values } )
    end
  end
  describe '.valid_url?' do
    it { expect(Bookmark).to respond_to(:valid_url?) }
    it { expect(Bookmark.valid_url?(bmark)).to eq(true) }
    it { expect(Bookmark.valid_url?('hello')).to eq(false)}
  end
  describe '#.add_bookmark' do
    it { expect(Bookmark).to respond_to(:add_bookmark).with(2).arguments }
    it 'can add a bookmark to the data base' do
      new_bookmark = { url: bmark, title: 'Capybara' }
      Bookmark.add_bookmark(new_bookmark[:url], new_bookmark[:title])
      expect(Bookmark.all.last).to eq(new_bookmark.values)
    end
  end
  describe '#rm_bookmark' do
    it { expect(Bookmark).to respond_to(:rm_bookmark).with(1) .arguments}
    it { expect(Bookmark.rm_bookmark(bmark)).to eq('not in db') }
    it 'can remove an added bookmark succesfully' do
      add_test_bookmarks_to_db
      Bookmark.rm_bookmark('Google')
      expect(Bookmark.all[0]).to_not eq(['https://www.google.com', 'Google'])
      expect(Bookmark.all[0]).to eq(['https://github.com/', 'Github'])
    end
  end
  describe '#clear_bookmarks' do
    it { expect(Bookmark).to respond_to(:clear_bookmarks) }
    it 'clears databse when called' do
      add_test_bookmarks_to_db
      Bookmark.clear_bookmarks
      expect(Bookmark.all.empty?).to eq(true)
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
