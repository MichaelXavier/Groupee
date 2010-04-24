class CreateMeetings < ActiveRecord::Migration
  def self.up
    create_table :meetings do |t|
      t.string :title
      t.datetime :from
      t.datetime :to
      t.string :location

      t.timestamps
    end
  end

  def self.down
    drop_table :meetings
  end
end
