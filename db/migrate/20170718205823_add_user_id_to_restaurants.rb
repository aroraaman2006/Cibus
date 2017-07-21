class AddUserIdToRestaurants < ActiveRecord::Migration[5.0]
  def change
  	add_reference :restaurants, :user, index: true
  	add_foreign_key :restaurants, :users
  end
end