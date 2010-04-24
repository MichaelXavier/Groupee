class AddAvailabilitiesGroups < ActiveRecord::Migration
  def self.up
    create_table :availabilities_groups, :id => false do |t|
      t.references :availability
      t.references :group
    end
  end

  def self.down
    drop_table :availabilities_groups
  end
end
