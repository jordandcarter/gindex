class CreateWebsiteIndexCounts < ActiveRecord::Migration
  def self.up
    create_table :website_index_counts do |t|
      t.integer :website_id
      t.integer :count

      t.timestamps
    end
  end

  def self.down
    drop_table :website_index_counts
  end
end
