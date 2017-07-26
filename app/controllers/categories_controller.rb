class CategoriesController < ApplicationController
	before_action :authorize
	before_action :check_admin
	before_action :find_category, except: [:index, :new, :create]
		def index	
			@categories = Category.all
		end

		def create
			@category = Category.new(category_params)
			if @category.save
				redirect_to categories_path
			else
				render 'new'
			end
		end

		def new			
			@category = Category.new
		end

		def edit
		end

		def update
			if @category.update(category_params)
				redirect_to categories_path
			else
			render 'edit', alert: "Update Unsuccesful!!"
			end
		end

		def destroy
			@category.destroy
			redirect_to categories_path, alert: "Category Deleted!"
		end

		private
		
		def category_params
			params.require(:category).permit(:name)
		end

		def check_admin
			if current_user.admin != true
				redirect_to root_path, alert: "Access Denied!"
			end
		end

		def find_category
			@category = Category.find(params[:id])
		end
end