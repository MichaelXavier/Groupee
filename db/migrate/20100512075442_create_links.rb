class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.integer :link_type_id
      t.integer :left_user_id
      t.integer :right_user_id
      t.integer :context_id
      t.string  :context_type

      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
