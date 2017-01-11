class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.string :item_name
      t.string :location
      t.text :description
      t.float :price
      t.integer :user_id

      t.timestamps
    end
  end
end
