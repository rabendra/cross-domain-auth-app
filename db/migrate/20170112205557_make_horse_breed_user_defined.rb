class MakeHorseBreedUserDefined < ActiveRecord::Migration[5.0]
  def change
    remove_column :horses, :breed, :integer
    add_column :horses, :breed, :string, index: true
  end
end
