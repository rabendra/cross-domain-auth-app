class CreateHorses < ActiveRecord::Migration[5.0]
  def change
    create_table :horses do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.string :photo
      t.integer :age
      t.integer :competition_type, default: 0
      t.integer :breed, default: 0

      t.timestamps
    end
  end
end
