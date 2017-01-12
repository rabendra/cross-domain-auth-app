class AddSsnToProfiles < ActiveRecord::Migration[5.0]
  def change
    change_table :profiles do |t|
      t.string :last_4_ssn
      t.string :stripe_managed_account_identifier, index: true
      t.string :stripe_customer_identifier, index: true
    end
  end
end
