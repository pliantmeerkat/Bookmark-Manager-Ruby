require 'sinatra'

class App < Sinatra::Base

  run! if app_file == $PROGRAM_NAME

  get '/' do
    'Bookmarks'
  end

end
