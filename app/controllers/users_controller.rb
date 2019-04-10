class UsersController < ApplicationController
  # use Rack::Flash

  get '/signup' do
    if !logged_in?
      erb :'/users/signup'
    else
      redirect '/welcome.html.erb'
    end
  end

  post '/signup' do
    if !logged_in?
      if params[:username].empty? || params[:password].empty? || params[:email].empty?
        flash[:message] = "Error -- Please make sure all fields are complete."
        redirect '/users/signup.html.erb'
      else
        @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        @user.save
        session[:id] = @user.id
        erb :'/reviews/index.html.erb'
      end
    else
      redirect '/users/signup.html.erb'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login.html.erb'
    else
      redirect '/welcome.html.erb'
    end
  end

  post '/login' do
    if !logged_in?
    @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/reviews/index.html.erb"
      else
        flash[:message] = "Error -- Please enter a valid username and/or password."
        redirect "/login.html.erb"
      end
    else
      redirect '/welcome.html.erb'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/"
    end
  end
end
