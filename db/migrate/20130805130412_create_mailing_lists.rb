class CreateMailingLists < ActiveRecord::Migration
  def change
    create_table :mailing_lists do |t|
      t.string :email
      t.boolean :subscribed, default: true

      t.timestamps
    end
    add_index :mailing_lists, :email, unique: true
  end
end
