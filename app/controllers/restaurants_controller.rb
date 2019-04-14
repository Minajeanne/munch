class RestaurantsController < ApplicationController

  get '/restaurants/index' do
    if logged_in?
      @restaurants = Restaurant.all.sort_by(&:name)
        @restaurants.each do |restaurant|
          restaurant.overall_rating
          @overall_rating = restaurant.overall_rating
           # binding.pry
        end
      erb :'/restaurants/index.html'
    else
      redirect '/login'
    end
  end

  get '/restaurants/new' do
    if logged_in?
      erb :'/restaurants/new.html'
    #   @restaurant = Restaurant.new(name: params[:name], cuisine: params[:cuisine], location: params[:location])
    #   @restaurant.user_id = session[:id]
    #     if @restaurant && @restaurant.user_id == current_user.id
    #       @restaurant.save
    #       redirect '/reviews/new'
    #     else
    #       redirect '/reviews/index'
    #     end
    # else
    #   redirect '/login'
   end
  end

  post '/restaurants/new' do
    if logged_in?
      @restaurant = Restaurant.new(name: params[:name], cuisine: params[:cuisine], location: params[:location])
        if @restaurant.save
          redirect '/reviews/new'
        else
          redirect '/reviews/index'
        end
    else
    redirect '/login'
    # how to limit multiple creations of the same restaurant?
    end
  end

  get '/restaurants/:id' do
    redirect to '/login' unless logged_in?
    @user = current_user
    @restaurant = Restaurant.find(params[:id])

    erb :'/restaurants/show.html'
  end

  get '/restaurants/:id/edit' do
    redirect to '/login' unless logged_in?
    @restaurant = Restaurant.find(params[:id])
      # if current_user.id != @review.user_id
      #   flash[:error] = "Oops! You can only edit a review that you created."
      #   redirect '/index'
      # end
    erb :'/restaurants/edit.html'
  end

  patch '/restaurants/:id' do
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(name: params[:name], cuisine: params[:cuisine], location: params[:location])
    @restaurant.save

    redirect to "/restaurants/#{restaurant.id}"
  end

  delete '/restaurants/:id' do
    redirect to '/login' unless logged_in?
    @user = current_user
    @restaurant = Restaurant.find(params[:id])

    flash[:message] = "You have succesfully deleted #{restaurant.name}."
    @restaurant.destroy
    redirect to "/restaurants/index"
  end
end
