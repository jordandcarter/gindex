class CreateUserWebsites < ActiveRecord::Migration
  def self.up
    create_table :user_websites do |t|
      t.integer :user_id
      t.integer :website_id

      t.timestamps
    end
  end

  def self.down
    drop_table :user_websites
  end
end
