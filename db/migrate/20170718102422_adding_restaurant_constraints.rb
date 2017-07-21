class AddingRestaurantConstraints < ActiveRecord::Migration[5.0]
  def change
	change_column :restaurants, :name, :string, null: false
	change_column :restaurants, :state, :string, null: false
	change_column :restaurants, :city, :string, null: false
	change_column :restaurants, :address, :string, null: false
  end
end