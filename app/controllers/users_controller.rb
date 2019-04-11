class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'/users/signup.html'
    else
      user = current_user
      redirect '/user/#{user.id}'
    end
  end

  post '/signup' do
    if !logged_in?
      if params[:full_name].empty? || params[:username].empty? || params[:password].empty? || params[:email].empty?
        flash[:message] = "Error -- Please make sure all fields are complete."
        redirect '/signup'
      else
        @user = User.new(full_name: params[:full_name], username: params[:username], email: params[:email], password: params[:password])
        @user.save
         # binding.pry
        session[:id] = @user.id
        erb :'/users/show.html'
      end
    else
      redirect '/'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login.html'
    else
      redirect '/'
    end
  end

  post '/login' do
    # binding.pry
    if !logged_in?
    @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        erb :'/users/show.html'
      else
        flash[:message] = "Error -- Please enter a valid username and/or password."
        redirect "/login"
      end
    else
      redirect '/'
    end
  end

  get '/users/:id' do
    @user = current_user
    if @user && @user.id == params[:id]
      erb :'/users/show'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/"
    end
  end
end
