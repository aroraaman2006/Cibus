class EditReviewModel < ActiveRecord::Migration[5.0]
  def change
  	remove_column :reviews, :restaurant_id, :integer


  	add_reference :reviews, :restaurant, index: true
  	add_foreign_key :reviews, :restaurants

  	add_reference :reviews, :user, index: true
  	add_foreign_key :reviews, :users
  end
end