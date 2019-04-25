require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'session_secret'
    register Sinatra::Flash
  end

  get "/" do
    erb :'/welcome.html'
  end

  helpers do
     def current_user
       session[:user_id] && User.find_by(id: session[:user_id])
     end

     def logged_in?
       !!current_user
     end
  end
end
