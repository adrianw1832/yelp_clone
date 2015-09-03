class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    if current_user.has_reviewed? @restaurant
      flash[:error] = 'You have reviewed this restaurant already!'
    else
      @restaurant.reviews.create(review_params)
    end
    redirect_to restaurants_path
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
