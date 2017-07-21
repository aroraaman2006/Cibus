class CategoriesController < ApplicationController
	before_action :authorize
		def index
			check_admin			
			@categories = Category.all
		end

		def create		
			check_admin
			@category = Category.new(category_params)

			if @category.save
				redirect_to categories_path
			else
				render 'new'
			end
		end

		def new	
			check_admin			
			@category = Category.new
		end

		private
		
		def category_params
			params.require(:category).permit(:name)
		end

		def authorize
			if current_user.nil?
				redirect_to login_url, alert: "Please Login First!"
			end
		end

		def check_admin
			if current_user.admin != true
				redirect_to root_path, alert: "Access Denied!"
			end
		end


end