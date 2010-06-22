class CreateGroupMemberships < ActiveRecord::Migration
  def self.up
    create_table :group_memberships do |t|
      t.boolean :leader, :default => false
      t.string :status
      t.references :user
      t.references :group

      t.timestamps
    end
  end

  def self.down
    drop_table :group_memberships
  end
end
