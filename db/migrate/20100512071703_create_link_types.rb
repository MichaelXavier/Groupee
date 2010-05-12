class CreateLinkTypes < ActiveRecord::Migration
  def self.up
    create_table :link_types do |t|
      t.string :name
      t.decimal :weight

      t.timestamps
    end
  end

  def self.down
    drop_table :link_types
  end
end
