class ReviewsController < ApplicationController

  get '/reviews/index' do
    if logged_in?
      @restaurants = Restaurant.all
      @reviews = Review.all
      @reviews = @reviews.sort_by(&:restaurant_id)
       # binding.pry

      erb :'/reviews/index.html'
    else
      redirect '/login'
    end
  end

  get '/reviews/new' do
    @restaurants = Restaurant.all
    @restaurants.sort_by(&:name)
     # binding.pry
    # if logged_in?
      erb :'reviews/new.html'
    # else
    #   redirect '/login'
    # end
  end

  post '/reviews/new' do
    @review = Review.new(title: params[:title], experience: params[:experience], rating: params[:rating])
    @review.user_id = session[:user_id]
    @review.restaurant_id = params[:restaurant_id]
      if @review && @review.user_id == current_user.id
        @review.save
 # binding.pry
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

  delete '/reviews/:id/delete' do
    redirect to '/login' unless logged_in?
      @user = current_user
      # binding.pry
      @review = Review.find(params[:id])
      # @restaurant = Restaurant.where(review: @review)
   # binding.pry
#####FIX THIS#######
    # if @user.user_id != @review.user_id
    #   flash[:error] = "Oops! You can only delete a review that you created."
    #   redirect "/reviews/#{@review.id}"
    # if @review.id && @review.user_id == @user.id
     if @review.user_id == @user.id
         @review.destroy
         flash[:message] = "You have succesfully deleted your review!"
         redirect to '/reviews/index'
         # redirect to "/reviews/#{@review.id}"
      else
      flash[:message] = "Oops! You can only delete a review that you created."
      redirect to "/reviews/#{@review.id}"
    end
  end
end
