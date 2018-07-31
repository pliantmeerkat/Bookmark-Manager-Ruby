require './model/bookmark'
describe Bookmark do
  let(:subject) { described_class.new }
  describe '.all' do
    it 'returns all bookmarks' do
      bookmarks = Bookmark.all
      expect(bookmarks).to include('https://www.google.com/')
      expect(bookmarks).to include('https://github.com/')
    end
  end
end
