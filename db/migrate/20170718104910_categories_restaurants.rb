class CategoriesRestaurants < ActiveRecord::Migration[5.0]
  def up
	create_table :categories_restaurants, :id => false do |t|
	t.integer "category_id"	
	t.integer "restaurant_id"
        end
    add_index("categories_restaurants", ["category_id","restaurant_id"])
  end

 def down
  drop table :categories_restaurants
 end
 
end
