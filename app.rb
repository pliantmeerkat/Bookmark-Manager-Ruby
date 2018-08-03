require 'sinatra/base'
require 'sinatra/flash'
require './model/bookmark'
# main App 
class App < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    # erb(:index)
    redirect('/bookmark')
  end

  get '/bookmark' do
    @bookmarks = Bookmark.all
    flash[:waring]
    erb(:bookmark)
  end

  get '/new' do
    erb(:new)
  end

  post '/add_bookmark' do
    url = params['Bookmark']
    if Bookmark.add_bookmark(url) == 'INVALID'
      flash[:warning] = 'Invalid Url'
      redirect('/bookmark')
    end
    flash[:warning] = 'Bookmark Added'
    redirect('/bookmark')
  end

  run! if app_file == $PROGRAM_NAME
end
