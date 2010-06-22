class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.string :title
      t.string :sln
      t.string :catalog_name
      t.string :section
      t.string :quarter
      t.integer :year
      t.integer :instructor_id

      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end
