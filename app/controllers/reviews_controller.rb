class ReviewsController < ApplicationController

  get '/reviews/index' do
    if logged_in?

      @review = Review.all
      erb :'/reviews/index.html'
    else
      redirect '/login'
    end
  end

  get '/reviews/new' do
    @restaurants = Restaurant.all
     # binding.pry
    # if logged_in?
      erb :'reviews/new.html'
    # else
    #   redirect '/login'
    # end
  end

  post '/reviews/new' do
    @review = Review.new(title: params[:title], experience: params[:experience], rating: params[:rating])
      # binding.pry
    @review.user_id = session[:user_id]
    @review.restaurant_id = params[:restaurant_id].to_i
      if @review && @review.user_id == current_user.id
        @review.save

        flash[:message] = "You have succesfully created #{@review.title}!"
        redirect to "/reviews/#{@review.id}"
      else
        redirect '/reviews/index'
      end
  end

  get '/reviews/:id' do
    redirect to '/login' unless logged_in?
    @user = current_user
    @review = Review.find(params[:id])

    erb :'/reviews/show.html'
  end

  get '/reviews/:id/edit' do
    redirect to '/login' unless logged_in?
    @review = Review.find(params[:id])
      if current_user.id != @review.user_id
        flash[:error] = "Oops! You can only edit a review that you created."
        redirect '/index'
      end
    erb :'/reviews/edit.html'
  end

  patch '/reviews/:id' do
    @review = Review.find(params[:id])
    @review.update(title: params[:title], experience: params[:experience], rating: params[:rating])
    @review.save

    redirect to "/reviews/#{@review.id}"
  end

  delete '/reviews/:id' do
    redirect to '/login' unless logged_in?
    @user = current_user
    @review = Review.find(params[:id])
    @restaurant = Restaurant.where(review: @review)

    if current_user.id != @review.user_id
      flash[:error] = "Oops! You can only edit a review that you created."
      redirect '/index'
    end

    flash[:message] = "You have succesfully deleted #{@review.title}!"
    @review.destroy && @restaurant.destroy_all
    redirect to "/reviews/index"
  end
end
