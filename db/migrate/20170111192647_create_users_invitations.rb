class CreateUsersInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :users_invitations do |t|
      t.references :requestor, index: true, foreign_key: { to_table: :users }
      t.string :email, null: false, index: true
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
