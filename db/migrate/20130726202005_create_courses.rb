class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :days_description
      t.string :class_time_description
      t.string :age_group
      t.string :tuition_description
      t.text :long_description
      t.integer :account_id

      t.timestamps
    end
  end
end
