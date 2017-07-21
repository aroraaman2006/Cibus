class RestaurantsController < ApplicationController
	before_action :authorize, except: [:show, :index]
		def index
			if params[:category].blank?
				@restaurants = (Restaurant.all).reverse
			else
				@category = Category.find_by_name(params[:category])
				@restaurants = @category.restaurants
			end
		end

		def show
			find_restaurant

			if @restaurant.reviews.blank?
				@average_review = 0
			else
				@average_review = @restaurant.reviews.average(:rating).round(2)
			end
		end

		def edit
			find_restaurant	
			if current_user.admin != true
				if @restaurant.user_id != current_user.id		
				redirect_to restaurant_path, notice: "Access Denied!!!"
				end
			end
		end

		def new
			@restaurant = Restaurant.new
		end

		def create  
			@restaurant = current_user.restaurants.build(restaurant_params)

			if @restaurant.save
				redirect_to root_path
			else
				render 'new'
			end
		end

		def update
			find_restaurant
			if @restaurant.update(restaurant_params)
				redirect_to restaurant_path(@restaurant)
			else
			render 'edit'
			end
		end

		def destroy
			find_restaurant
			if @restaurant.user_id == current_user.id
				@restaurant.destroy
				redirect_to root_path
			else
			redirect_to restaurant_path, alert: "Access Denied!"
			end
		end

		def remove_photo
		    find_restaurant
		    @restaurant.restaurant_img = nil
		    @restaurant.save
		    redirect_to @restaurant, flash: { success: 'User profile photo has been removed.' }
  		end

		private

		def restaurant_params
			params.require(:restaurant).permit(:name, :state, :city, :area, :address, :restaurant_img, category_ids: [])
		end

		def find_restaurant
			@restaurant=Restaurant.find(params[:id])
		end

		def authorize
			if current_user.nil?
				redirect_to login_url, alert: "Please Login First!"
			end		
		end
end