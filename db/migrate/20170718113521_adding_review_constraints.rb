class AddingReviewConstraints < ActiveRecord::Migration[5.0]
  def change
  	change_column :reviews, :rating, :integer, null: false
	change_column :reviews, :comment, :text, null: false
  end
end
