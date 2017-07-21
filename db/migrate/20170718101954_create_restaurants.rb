class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :state
      t.string :city
      t.string :area
      t.string :address

      t.timestamps
    end
  end
end
