require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    register Sinatra::Flash
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
  end

  get "/" do
    flash[:notice] = "WOAH"
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
