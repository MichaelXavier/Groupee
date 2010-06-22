class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.string :name
      t.integer :course_id
      t.datetime :assigned
      t.datetime :due
      t.integer :user_limit, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end
end
