class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string

    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.date :birth_date
      t.text :bio

      t.integer :profile_type, default: 0, null: false
      t.index :profile_type

      t.string :type, index: true

      t.timestamps
    end
  end
end
