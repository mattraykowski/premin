class AddColumnIsSiteAdminToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :is_site_admin, default: false
    end
  end
end
