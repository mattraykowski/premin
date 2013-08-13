class CreateCourseSessions < ActiveRecord::Migration
  def change
    create_table :course_sessions do |t|
      t.string :name
      t.references :course
      t.integer :status
      t.integer :total_capacity
      t.integer :waitlist_capacity

      t.timestamps
    end
    add_index :course_sessions, :course_id
  end
end
