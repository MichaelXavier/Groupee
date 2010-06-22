class AddMeetingsUsers < ActiveRecord::Migration
  def self.up
    create_table :meetings_users, :id => false do |t|
      t.integer :meeting_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :meetings_users
  end
end
