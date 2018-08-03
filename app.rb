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

  get '/delete' do
    erb(:remove_bookmark)
  end

  get '/clear' do
    flash[:warning] = 'Bookmarks Cleared'
    Bookmark.clear_bookmarks
    redirect('/bookmark')
  end

  post '/delete-bookmark' do
    if Bookmark.rm_bookmark(params['Bookmark']) == 'not in db'
      flash[:warning] = 'Bookmark not in database'
      redirect('/delete')
    end
    flash[:warning] = 'Bookmark Deleted'
    redirect('/bookmark')
  end

  post '/add_bookmark' do
    title = params['title']
    url = params['Bookmark']
    if Bookmark.add_bookmark(url, title) == 'INVALID'
      flash[:warning] = 'Invalid Url'
      redirect('/new')
    end
    flash[:warning] = 'Bookmark Added'
    redirect('/bookmark')
  end

  run! if app_file == $PROGRAM_NAME
end
