class AddAccountToPages < ActiveRecord::Migration
  def change
    add_column :pages, :account_id, :integer
  end
end
