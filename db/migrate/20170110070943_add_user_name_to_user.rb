class AddUserNameToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :username, :string
    add_column :users, :provider_id, :string
    add_column :users, :authentication_token, :string
    add_column :users, :provider, :string

  end
end
