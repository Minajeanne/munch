class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'/users/signup.html'
    else
      redirect '/welcome'
    end
  end

  post '/signup' do
    if !logged_in?
      if params[:username].empty? || params[:password].empty? || params[:email].empty?
        flash[:message] = "Error -- Please make sure all fields are complete."
        redirect '/signup'
      else
        @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        @user.save
        # binding.pry
        session[:id] = @user.id
        erb :'/reviews/index.html'
      end
    else
      redirect '/'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login.html'
    else
      redirect '/welcome'
    end
  end

  post '/login' do
    # binding.pry
    if !logged_in?
    @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        erb :'/reviews/index.html'
      else
        flash[:message] = "Error -- Please enter a valid username and/or password."
        redirect "/login"
      end
    else
      redirect '/welcome'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/"
    end
  end
end
