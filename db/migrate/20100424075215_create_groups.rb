class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :name
      t.integer :user_limit, :default => 2
      t.string :status,      :default => 'active'
      t.string :website
      t.boolean :open,       :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end
