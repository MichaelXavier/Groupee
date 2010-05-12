class LinkGroupToCourse < ActiveRecord::Migration
  def self.up
    add_column :groups, :course_id, :integer
  end

  def self.down
    remove_column :groups, :course_id
  end
end
