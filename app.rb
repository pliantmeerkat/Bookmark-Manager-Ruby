require 'sinatra'
require './model/bookmark'

class App < Sinatra::Base
  get '/' do
    # erb(:index)
    redirect('/bookmark')
  end

  get '/bookmark' do
    @bookmarks = Bookmark.all
    erb(:bookmark)
  end

  run! if app_file == $PROGRAM_NAME
end
