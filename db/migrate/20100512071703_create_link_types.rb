class CreateLinkTypes < ActiveRecord::Migration
  def self.up
    create_table :link_types do |t|
      t.string :name
      t.decimal :weight, :default => 0.0, :precision => 3, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :link_types
  end
end
