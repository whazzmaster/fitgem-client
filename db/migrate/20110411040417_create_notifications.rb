class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.string :user_id
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :notifications
  end
end
