class ReviewsController < ApplicationController
	before_action :authorize
	def new
		find_restaurant
		@review = Review.new
	end

	def create
		find_restaurant
		@review = Review.new(review_params)
		@review.restaurant_id = @restaurant.id
		@review.user_id = current_user.id

		if @review.save
			redirect_to restaurant_path(@restaurant)
		else
			render 'new'
		end
	end

	def edit
		find_restaurant
		find_review

		if @review.user_id != current_user.id
			redirect_to root_path, notice: "Access Denied!!!"
		end
		
	end

	def update
		find_restaurant
		find_review
			if @review.update(review_params)
			redirect_to restaurant_path(@restaurant)
			else
			render 'edit'
			end
	end

	def destroy
		find_restaurant
		find_review
		@review.destroy
		redirect_to restaurant_path(@restaurant)
	end

	private

	def review_params
		params.require(:review).permit(:rating, :comment)
	end

	def find_restaurant
		@restaurant = Restaurant.find(params[:restaurant_id])
	end

	def find_review
		@review = Review.find(params[:id])
	end

	def authorize
		if current_user.nil?
			redirect_to login_url, alert: "Please Login First!"
		end		
	end

end