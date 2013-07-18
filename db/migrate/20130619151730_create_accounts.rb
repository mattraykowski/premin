class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :subdomain_name
      t.integer :user_id

      t.timestamps
    end
    add_index :account, :subdomain_name, :unique => true
  end
end
