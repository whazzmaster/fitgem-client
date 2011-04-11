class CreateFitbitAccounts < ActiveRecord::Migration
  def self.up
    create_table :fitbit_accounts do |t|
      t.integer :user_id
      t.string :request_token
      t.string :request_secret
      t.string :access_token
      t.string :access_secret
      t.string :verifier
      t.string :fb_user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :fitbit_accounts
  end
end
