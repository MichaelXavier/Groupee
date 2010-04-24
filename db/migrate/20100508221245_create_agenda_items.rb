class CreateAgendaItems < ActiveRecord::Migration
  def self.up
    create_table :agenda_items do |t|
      t.string :name
      t.text :description
      t.integer :meeting_id
      t.boolean :completed, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :agenda_items
  end
end
