class RestaurantsController < ApplicationController
	before_action :authorize, except: [:show, :index]
	before_action :find_restaurant, except: [:index, :new, :create]
		def index
			if params[:category].blank?
				@restaurants = (Restaurant.all).reverse
			else
				@category = Category.find_by_name(params[:category])
				@restaurants = @category.restaurants
			end
		end

		def show
			if @restaurant.reviews.blank?
				@average_review = 0
			else
				@average_review = @restaurant.reviews.average(:rating).round(2)
			end
		end

		def edit	
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
			if @restaurant.update(restaurant_params)
				redirect_to restaurant_path(@restaurant)
			else
			render 'edit', alert: "Update Unsuccesful!!"
			end
		end

		def destroy
			if ((@restaurant.user_id == current_user.id) or (current_user.admin = true))
				@restaurant.destroy
				redirect_to root_path, alert: "Restaurant Deleted!"
			else
			redirect_to restaurant_path, alert: "Access Denied!"
			end
		end

		def remove_photo
		    find_restaurant
		    @restaurant.restaurant_img = nil
		    @restaurant.save
		    redirect_to @restaurant, flash: { success: 'Restaurant photo has been removed.' }
  		end

		private

		def restaurant_params
			params.require(:restaurant).permit(:name, :state, :city, :area, :address, :restaurant_img, category_ids: [])
		end

		def find_restaurant
			@restaurant=Restaurant.find(params[:id])
		end
end