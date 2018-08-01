require 'sinatra/base'
require 'sinatra/flash'
require './model/bookmark'
class App < Sinatra::Base

  enable :sessions
  register Sinatra::Flash

  get '/' do
    # erb(:index)
    
    redirect('/bookmark')
  end

  get '/bookmark' do
    @bookmarks = Bookmark.all
    erb(:bookmark)
  end

  get '/route' do
    redirect('/new')
  end

  get '/new' do
    erb(:new)
  end

  post '/add_bookmark' do
    url = params
    Bookmark.add_bookmark(url)
    redirect('/bookmark')
  end

  run! if app_file == $PROGRAM_NAME
end
