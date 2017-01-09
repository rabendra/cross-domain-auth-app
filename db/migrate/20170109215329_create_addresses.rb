class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :street_2
      t.string :city
      t.string :state, length: 2
      t.string :zip_code, length: 10
      t.string :country
      t.float :latitude
      t.float :longitude
      t.integer :addressable_id
      t.string :addressable_type

      t.index :country
      t.index [:addressable_id, :addressable_type]
      t.index [:latitude, :longitude]

      t.timestamps null: false
    end
  end
end
