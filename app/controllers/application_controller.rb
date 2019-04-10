require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    register Sinatra::Flash
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET')
  end

  get "/" do
    erb :"/welcome.html"
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
