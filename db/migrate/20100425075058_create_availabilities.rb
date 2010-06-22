class CreateAvailabilities < ActiveRecord::Migration
  def self.up
    create_table :availabilities do |t|
      t.integer :day_of_week
      t.time :from
      t.time :to
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :availabilities
  end
end
